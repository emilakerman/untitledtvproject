//
//  ProfileView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-30.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseStorage

struct ProfileView: View {
    let db = Firestore.firestore()
    @State var image: ApiShows.Image?
    
    //language lists
    @State var englishList : [ApiShows.Returned] = []
    @State var swedishList : [ApiShows.Returned] = []
    @State var koreanList : [ApiShows.Returned] = []
    @State var thaiList : [ApiShows.Returned] = []
    @State var chineseList : [ApiShows.Returned] = []
    @State var japaneseList : [ApiShows.Returned] = []
    @State var danishList : [ApiShows.Returned] = []
    @State var norwegianList : [ApiShows.Returned] = []
    @State var germanList : [ApiShows.Returned] = []
    @State var frenchList : [ApiShows.Returned] = []
    @State var dutchList : [ApiShows.Returned] = []
    @State var polishList : [ApiShows.Returned] = []
    @State var spanishList : [ApiShows.Returned] = []
    @State var turkishList : [ApiShows.Returned] = []
    @State var greekList : [ApiShows.Returned] = []
    @State var allLanguages : [ApiShows.Returned] = []
    //genre lists
    @State var dramaList : [ApiShows.Returned] = []
    @State var comedyList : [ApiShows.Returned] = []
    @State var scifiList : [ApiShows.Returned] = []
    @State var horrorList : [ApiShows.Returned] = []
    @State var crimeList : [ApiShows.Returned] = []
    @State var adventureList : [ApiShows.Returned] = []
        
    var user = Auth.auth().currentUser
    let storage = Storage.storage() //storage for user selected profile picture
    
    @State var signedIn = true
    @State var wantToSignUp = false
    @State var createdAccount = false
    
    @State var showingLangWindow = false
    @State var showingGenreWindow = false
    
    @State var showingSettingsAlert = false
    @State var selectedUserName : String
    @State var userName : String?
    
    @State var profileImage = UIImage()
    @State private var showSheet = false
    
    var storageManager = StorageManager()
        
    var body: some View {
        if !signedIn {
            LoginView(signedIn: $signedIn, wantToSignUp: $wantToSignUp, createdAccount: $createdAccount)
        } else {
            VStack {
                HStack {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(Color.black.opacity(0.2))
                        .clipShape(Circle())
                        .padding(10)
                        .padding(.top, 10)
                        .onAppear() { //reading and setting profile picture from firebase storage
                            let storageRef = storage.reference().child("images/image.jpg")

                            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                if error != nil {
                                print("error downloading image from storage")
                              } else {
                                  self.profileImage = UIImage(data: data!)!
                              }
                            }
                        }
                        .onChange(of: profileImage, perform: { image in
                                storageManager.upload(image: image) //uploads selected profile picture to firebase storage
                        })
                        .onTapGesture() {
                            showSheet = true
                        }
                        .sheet(isPresented: $showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                        }
                    Text((userName) ?? "")
                    Spacer()
                    Button(action: {
                        logOut()
                    }) {
                        Image("logout.b")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(10)
                    .padding(.top, 10)
                }
                Divider()
                 .frame(height: 1)
                 .padding(.horizontal, 30)
                Spacer()
                Text("Another way of seeing your data")
                Spacer()
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))
                            .aspectRatio(1.0, contentMode: .fit)
                        Canvas { context, size in
                            let slices: [(Double, Color)] = [(Double(englishList.count), .red),
                                                             (Double(swedishList.count), .blue),
                                                             (Double(koreanList.count), .green),
                                                             (Double(thaiList.count), .purple),
                                                             (Double(chineseList.count), .yellow),
                                                             (Double(japaneseList.count), .black),
                                                             (Double(danishList.count), .pink),
                                                             (Double(norwegianList.count), .cyan),
                                                             (Double(germanList.count), .orange),
                                                             (Double(frenchList.count), .teal),
                                                             (Double(dutchList.count), .white),
                                                             (Double(polishList.count), .mint),
                                                             (Double(spanishList.count), .indigo),
                                                             (Double(turkishList.count), .gray),
                                                             (Double(greekList.count), .brown)]
                            let total = slices.reduce(0) { $0 + $1.0 }
                            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                            var pieContext = context
                            pieContext.rotate(by: .degrees(-90))
                            let radius = min(size.width, size.height) * 0.48
                            var startAngle = Angle.zero
                            for (value, color) in slices {
                                let angle = Angle(degrees: 360 * (value / total))
                                let endAngle = startAngle + angle
                                let path = Path { p in
                                    p.move(to: .zero)
                                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                                    p.closeSubpath()
                                }
                                pieContext.fill(path, with: .color(color))

                                startAngle = endAngle
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        Button("Languages") {
                            showingLangWindow = true
                        }
                        .foregroundColor(.white)
                        .alert("Percentage split", isPresented: $showingLangWindow) { //change so it doesnt show empty language lists
                            VStack {
                                Button("English: \(Double(englishList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Swedish: \(Double(swedishList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Korean: \(Double(koreanList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Thai: \(Double(thaiList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Chinese: \(Double(chineseList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                                Button("Cancel", role: .cancel) { }
                            }
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))
                            .aspectRatio(1.0, contentMode: .fit)
                        Canvas { context, size in
                            let slices: [(Double, Color)] = [(Double(comedyList.count), .red),
                                                             (Double(dramaList.count), .blue),
                                                             (Double(horrorList.count), .green),
                                                             (Double(scifiList.count), .purple),
                                                             (Double(crimeList.count), .teal),
                                                             (Double(adventureList.count), .gray)]
                            let total = slices.reduce(0) { $0 + $1.0 }
                            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                            var pieContext = context
                            pieContext.rotate(by: .degrees(-90))
                            let radius = min(size.width, size.height) * 0.48
                            var startAngle = Angle.zero
                            for (value, color) in slices {
                                let angle = Angle(degrees: 360 * (value / total))
                                let endAngle = startAngle + angle
                                let path = Path { p in
                                    p.move(to: .zero)
                                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                                    p.closeSubpath()
                                }
                                pieContext.fill(path, with: .color(color))

                                startAngle = endAngle
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        Button("Genres") {
                            showingGenreWindow = true
                        }
                        .foregroundColor(.white)
                        .alert(/*"Percentage split"*/"Individual split", isPresented: $showingGenreWindow) { //showing counts instead of percentage for genres
                            VStack {
                                Button("Comedy: \(comedyList.count)") {}
                                Button("Drama: \(dramaList.count)") {}
                                Button("Horror: \(horrorList.count)") {}
                                Button("Science-Fiction: \(scifiList.count)") {}
                                Button("Crime: \(crimeList.count)") {}
                                Button("Adventure: \(adventureList.count)") {}
                                Button("Cancel", role: .cancel) { }
                            }
                        }
                    }
                }
                Text("Your completed shows")
                .padding(10)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(allLanguages, id: \.show.summary.hashValue) { show in
                                AsyncImage(url: URL(string: show.show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 250, height: 300)
                            }
                        }
                    }
                }
                Spacer()
            }
            .task { //read data from firestore to graphs
                DispatchQueue.main.async {
                    listenToFireStore()
                    listenToSettingsFireStore()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        NavigationLink(destination: OverView(selectedRowBgColor: "", selectedTextColor: "")) {
                            Image("house.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("redstats")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("plus.app")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        Button(action: {
                            showingSettingsAlert = true
                        }) {
                            Image("square.and.pencil.circle.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        .alert("Settings", isPresented: $showingSettingsAlert) {
                            VStack {
                                TextField("Enter desired username", text: $selectedUserName)
                                Button("Save") {
                                    saveSettingsToFireStore(selectedUserName: selectedUserName)
                                }
                                Button("Cancel", role: .cancel) { }
                            }
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("person.crop.circle.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(Color(.systemGray6))
        }
    }
    func uploadImage(profileImage: UIImage) {
        let storageRef = storage.reference()

        // File located on disk
        let localFile = URL(string: "path/to/image")!
        //let localFile = profileImage

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/profilePic.jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          /*
           riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              print("Uh-oh, an error occurred!")
              return
            }
          }*/
        }
    }
    func listenToSettingsFireStore() {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("Settings").document("ProfileSettings").addSnapshotListener { documentSnapshot, err in
            
            guard let document = documentSnapshot else {
                print("Error fetching document: \(err!)")
                return
            }
            guard let data = document.data() else {
                userName = user.email
                return
            }
            userName = data["name"] as? String ?? ""
        }
    }
    func saveSettingsToFireStore(selectedUserName: String) {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else {return}
        db.collection("users").document(user.uid).collection("Settings").document("ProfileSettings").setData([
                "name": selectedUserName,
                //"something": "123",
                //"something2": "1234"
                ])
            { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    func listenToFireStore() {
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("completed").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                allLanguages.removeAll()
                clearLists()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        allLanguages.append(show)
                        clearLists()
                        for show in allLanguages {
                            if show.show.language == "English" {
                                englishList.append(show)
                            }
                            if show.show.language == "Swedish" {
                                swedishList.append(show)
                            }
                            if show.show.language == "Korean" {
                                koreanList.append(show)
                            }
                            if show.show.language == "Thai" {
                                thaiList.append(show)
                            }
                            if show.show.language == "Chinese" {
                                chineseList.append(show)
                            }
                            if show.show.language == "Japanese" {
                                japaneseList.append(show)
                            }
                            if show.show.language == "Danish" {
                                danishList.append(show)
                            }
                            if show.show.language == "Norwegian" {
                                norwegianList.append(show)
                            }
                            if show.show.language == "German" {
                                germanList.append(show)
                            }
                            if show.show.language == "French" {
                                frenchList.append(show)
                            }
                            if show.show.language == "Dutch" {
                                dutchList.append(show)
                            }
                            if show.show.language == "Polish" {
                                polishList.append(show)
                            }
                            if show.show.language == "Spanish" {
                                spanishList.append(show)
                            }
                            if show.show.language == "Turkish" {
                                turkishList.append(show)
                            }
                            if show.show.language == "Greek" {
                                greekList.append(show)
                            }
                            if show.show.genres!.contains("Comedy") {
                                comedyList.append(show)
                            }
                            if show.show.genres!.contains("Drama") {
                                dramaList.append(show)
                            }
                            if show.show.genres!.contains("Horror") {
                                horrorList.append(show)
                            }
                            if show.show.genres!.contains("Science-Fiction") {
                                scifiList.append(show)
                            }
                            if show.show.genres!.contains("Crime") {
                                crimeList.append(show)
                            }
                            if show.show.genres!.contains("Adventure") {
                                adventureList.append(show)
                            }
                        }
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
    func clearLists() {
        englishList.removeAll()
        swedishList.removeAll()
        koreanList.removeAll()
        thaiList.removeAll()
        chineseList.removeAll()
        japaneseList.removeAll()
        danishList.removeAll()
        norwegianList.removeAll()
        germanList.removeAll()
        frenchList.removeAll()
        dutchList.removeAll()
        polishList.removeAll()
        spanishList.removeAll()
        turkishList.removeAll()
        greekList.removeAll()
        
        dramaList.removeAll()
        comedyList.removeAll()
        horrorList.removeAll()
        scifiList.removeAll()
        crimeList.removeAll()
        adventureList.removeAll()
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            //Auth.auth().currentUser == nil
            signedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

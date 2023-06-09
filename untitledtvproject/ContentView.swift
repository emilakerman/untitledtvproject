//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

let db = Firestore.firestore()

struct ContentView: View {
    
    @State var signedIn = false
    
    @State var wantToSignUp = false
    
    @State var createdAccount = false
    
    var body: some View {
        if Auth.auth().currentUser != nil || signedIn {
            OverView(selectedRowBgColor: "", selectedTextColor: "")
        }
        if Auth.auth().currentUser == nil && !wantToSignUp {
            LoginView(signedIn: $signedIn, wantToSignUp: $wantToSignUp, createdAccount: $createdAccount)
        }
        if Auth.auth().currentUser == nil && wantToSignUp {
            SignUpView(wantToSignUp: $wantToSignUp, createdAccount: $createdAccount, signedIn: $signedIn)
        }
    }
}
struct LoginView : View {
    
    @Binding var signedIn : Bool
    @Binding var wantToSignUp : Bool
    @Binding var createdAccount : Bool
    
    @State var userInput : String = ""
    @State var pwInput : String = ""
    
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    var buttonColor = Color(red: 38 / 255, green: 38 / 255, blue: 55 / 255)
    var bgColorDark = Color(red: 26 / 255, green: 27 / 255, blue: 41 / 255)
    var bgColorBrighter = Color(red: 57 / 255, green: 34 / 255, blue: 76 / 255)
    
    @State var showingInvalidLoginAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [bgColorBrighter, bgColorDark]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: "play.tv")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(Font.custom("Baskerville-Bold", size: 26))
                    ZStack(alignment: .leading) {
                        if userInput.isEmpty {
                            Text("your email")
                                .padding()
                                .background(.clear)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                        }
                        TextField("", text: $userInput)
                            .padding()
                            .background(.clear)
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    Divider()
                        .overlay(.white)
                        .frame(height: 1)
                        .padding(.top, -35)
                        .padding(.leading, 55)
                        .padding(.trailing, 55)
                    ZStack(alignment: .leading) {
                        if pwInput.isEmpty {
                            Text("your password")
                                .padding()
                                .background(.clear)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                        }
                        SecureField("your password", text: $pwInput)
                            .padding()
                            .background(.clear)
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    Divider()
                        .overlay(.white)
                        .frame(height: 1)
                        .padding(.top, -35)
                        .padding(.leading, 55)
                        .padding(.trailing, 55)
                    Button(action: { signIn() }) {
                        Text("Sign in")}
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(buttonColor)
                    .cornerRadius(15.0)
                    .padding(.bottom, 10)
                    NavigationLink(destination: SignUpView(wantToSignUp: $wantToSignUp, createdAccount: $createdAccount, signedIn: $signedIn)) {
                        Text("No account? Create account here")
                    }
                    .isDetailLink(false)
                }
            }
        }
        .alert("Invalid login", isPresented: $showingInvalidLoginAlert) {}
        .navigationBarBackButtonHidden(true)
    }
    func signIn() {
        Auth.auth().signIn(withEmail: userInput, password: pwInput) { (result, error) in
            if error != nil {
                //errorMsg = error?.localizedDescription ?? ""
                showingInvalidLoginAlert = true
            } else {
                signedIn = true
            }
        }
    }
}
struct SignUpView : View {
    
    @Binding var wantToSignUp : Bool
    @Binding var createdAccount : Bool
    @Binding var signedIn : Bool
    
    @State var userInput : String = ""
    @State var pwInput : String = ""
    
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    var buttonColor = Color(red: 38 / 255, green: 38 / 255, blue: 55 / 255)
    var bgColorDark = Color(red: 26 / 255, green: 27 / 255, blue: 41 / 255)
    var bgColorBrighter = Color(red: 57 / 255, green: 34 / 255, blue: 76 / 255)
    
    @State var showingInvalidLoginAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [bgColorBrighter, bgColorDark]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: "play.tv")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                    Text("Sign up")
                        .foregroundColor(.white)
                        .font(Font.custom("Baskerville-Bold", size: 26))
                    ZStack(alignment: .leading) {
                        if userInput.isEmpty {
                            Text("your email")
                                .padding()
                                .background(.clear)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                        }
                        TextField("", text: $userInput)
                            .padding()
                            .background(.clear)
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    Divider()
                        .overlay(.white)
                        .frame(height: 1)
                        .padding(.top, -35)
                        .padding(.leading, 55)
                        .padding(.trailing, 55)
                    ZStack(alignment: .leading) {
                        if pwInput.isEmpty {
                            Text("your password")
                                .padding()
                                .background(.clear)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                        }
                        SecureField("your password", text: $pwInput)
                            .padding()
                            .background(.clear)
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    Divider()
                        .overlay(.white)
                        .frame(height: 1)
                        .padding(.top, -35)
                        .padding(.leading, 55)
                        .padding(.trailing, 55)
                    Button(action: { signUp() }) {
                        Text("Sign up")}
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(buttonColor)
                    .cornerRadius(15.0)
                    .padding(.bottom, 10)
                    NavigationLink(destination: LoginView(signedIn: $signedIn, wantToSignUp: $wantToSignUp, createdAccount: $createdAccount)) {
                        Text("Already got an account? Sign in!")
                    }
                    .isDetailLink(false)
                }
            }
        }
        .alert("Invalid details", isPresented: $showingInvalidLoginAlert) {}
        .navigationBarBackButtonHidden(true)
    }
    func signUp() {
        Auth.auth().createUser(withEmail: userInput, password: pwInput) { result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
            if (result?.user.uid != nil) { createdAccount = true ; wantToSignUp = false ; signedIn = true }
        }
    }
}
struct SearchView : View {
    
    @StateObject var showList = ShowList()
    @State private var searchText = ""
    
    var filteredMessages: [ApiShows.Returned] {
        return (showList.lists[.searchList]?.filter { $0.show.name.localizedCaseInsensitiveContains(searchText) })!
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredMessages, id: \.show.summary.hashValue) { returned in
                        NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                            Text(returned.show.name)
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a show")
                .onSubmit(of: .search, getData)
                .disableAutocorrection(true)
                .toolbar {
                    NavigationLink(destination: ExploreView()) { Text("Explore") }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack {
                            NavigationLink(destination: OverView(selectedRowBgColor: "", selectedTextColor: "")) {
                                Image("house.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .isDetailLink(false)
                            Spacer()
                            NavigationLink(destination: StatsView()) {
                                
                                Image("redstats")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image("magnifyingglass.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image("square.and.pencil.circle.fill_grey")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            NavigationLink(destination: ProfileView(selectedUserName: "", userName: "")) {
                                Image("person.crop.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .isDetailLink(false)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    func getData() {
        
        searchText = searchText.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.tvmaze.com/search/shows?q=\(searchText)"
        
        print("trying to access the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error could not create url from \(urlString)")
            return
        }
        searchText = searchText.replacingOccurrences(of: "%20", with: " ") //problem med house of the dragon "-" "-" something
        
        showList.lists[.searchList]?.removeAll()
        
        //create urlsession
        let session = URLSession.shared
        //get data with .dataTask
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            //deal with the data
            do {
                showList.lists[.searchList]? = try JSONDecoder().decode([ApiShows.Returned].self, from: data!)
            } catch {
                print("catch: json error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
struct OverView : View {
    
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    let db = Firestore.firestore()
    
    @State var showingAlert = false
    
    @State var showingSettingsAlert = false
    @State var showRowBgColorAlert = false
    @State var showRowTextColorAlert = false
    
  
    @State var selectedRowBgColor : String
    @State var selectedTextColor : String
    @State private var rowColor = Color.white
    @State private var textColor = Color.black
    @State var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Want to watch")) {
                        ForEach(showList.lists[.wantToWatch]!, id: \.show.summary.hashValue) { returned in //show.summary.hashValue istället för ett unikt ID, summary är alltid unikt
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowView(showView: returned)
                            }
                            .listRowBackground(rowColor)
                            .foregroundColor(textColor)
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .wantToWatch)
                        }
                    }
                    Section(header: Text("Watching")) {
                        ForEach(showList.lists[.watching]!, id: \.show.summary.hashValue) { returned in
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowView(showView: returned)
                            }
                            .listRowBackground(rowColor)
                            .foregroundColor(textColor)
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .watching)
                        }
                    }
                    .onAppear() {
                        listenToFireStore()
                        listenToSettingsFireStore()
                    }
                    Section(header: Text("Completed")) {
                        ForEach(showList.lists[.completed]!, id: \.show.summary.hashValue) { returned in
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowView(showView: returned)
                            }
                            .listRowBackground(rowColor)
                            .foregroundColor(textColor)
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .completed)
                        }
                    }
                    Section(header: Text("Dropped")) {
                        ForEach(showList.lists[.dropped]!, id: \.show.summary.hashValue) { returned in
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowView(showView: returned)
                            }
                            .listRowBackground(rowColor)
                            .foregroundColor(textColor)
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .dropped)
                        }
                    }
                    Section(header: Text("Recently deleted")) {
                        ForEach(showList.lists[.recentlyDeleted]!, id: \.show.summary.hashValue) { returned in
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowView(showView: returned)
                            }
                            .listRowBackground(rowColor)
                            .foregroundColor(textColor)
                        }
                    }
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                //do nothing
                            }) {
                                Image("house.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            NavigationLink(destination: StatsView()) {
                                
                                Image("redstats")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            NavigationLink(destination: SearchView()) {
                                
                                Image("magnifyingglass.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .isDetailLink(false)
                            Spacer()
                            Button(action: {
                                showingSettingsAlert = true
                            }) {
                                Image("square.and.pencil.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .alert("Settings", isPresented: $showingSettingsAlert) {
                                VStack {
                                    Button("Row background color") {
                                        showRowBgColorAlert = true
                                    }
                                    Button("Row text color") {
                                        showRowTextColorAlert = true
                                    }
                                    Button("Toggle Dark mode") {
                                        if isDarkMode == false {
                                            isDarkMode = true
                                        } else {
                                            isDarkMode = false
                                        }
                                    }
                                    Button("Cancel", role: .cancel) { }
                                }
                            }
                            .alert("Select row background color", isPresented: $showRowBgColorAlert) {
                                //
                                selsectBackgroundBtns()
                            }
                            .alert("Select row text color", isPresented: $showRowTextColorAlert) {
                                selectRowbtns()
                            }
                            Spacer()
                            NavigationLink(destination: ProfileView(selectedUserName: "", userName: "")) {
                                Image("person.crop.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .isDetailLink(false)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
 
    func listenToSettingsFireStore() {
        @State var rowColor = Color.white
        @State var textColor = Color.black
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("Settings").document("OverviewSettings").addSnapshotListener { documentSnapshot, err in
            
            guard let document = documentSnapshot else {
                print("Error fetching document: \(err!)")
                return
            }
            guard let data = document.data() else {
                return
            }
            //Sets the text color and row color from saved settings in firestore
            let returnedRowColor = ("\(Color(data["rowBgColor"] as! CGColor))")
            let returnedTextColor = ("\(Color(data["textColor"] as! CGColor))")
            
            switch returnedRowColor {
            case let str where str.contains("purple"):
                rowColor = Color.purple
            case let str where str.contains("green"):
                rowColor = Color.green
            case let str where str.contains("blue"):
                rowColor = Color.blue
            case let str where str.contains("red"):
                rowColor = Color.red
            case let str where str.contains("orange"):
                rowColor = Color.orange
            case let str where str.contains("white"):
                rowColor = Color.white
            case let str where str.contains("black"):
                rowColor = Color.black
            default:
                break
            }
            switch returnedTextColor {
            case let str where str.contains("purple"):
                textColor = Color.purple
            case let str where str.contains("green"):
                textColor = Color.green
            case let str where str.contains("blue"):
                textColor = Color.blue
            case let str where str.contains("red"):
                textColor = Color.red
            case let str where str.contains("orange"):
                textColor = Color.orange
            case let str where str.contains("white"):
                textColor = Color.white
            case let str where str.contains("black"):
                textColor = Color.black
            default:
                break
            }
        }
    }
    func listenToFireStore() { //should probably make this shorter
        
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("watching").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.watching]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.watching]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("completed").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.completed]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.completed]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("dropped").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.dropped]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.dropped]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("wantToWatch").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.wantToWatch]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.wantToWatch]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("recentlyDeleted").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.recentlyDeleted]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.recentlyDeleted]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
}
struct RowView : View {
    var showView : ApiShows.Returned
    @State var showingAlert = false
    @State var listChoice = ""
    @State var collectionPath = ""
    
    let db = Firestore.firestore()
    @StateObject var showList = ShowList()
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                .onTapGesture {
                    showingAlert = true
                    listenToFireStore()
                    //fireStoreManager.listenToFireStore()
                }
            Text(showView.show.name)
        }
        .alert("Move to what list?", isPresented: $showingAlert) {
            VStack {
                Button("Want to watch") {
                    listChoice = "wantToWatch"
                    changeListFireStore()
                }
                Button("Watching") {
                    listChoice = "watching"
                    changeListFireStore()
                }
                Button("Completed") {
                    listChoice = "completed"
                    changeListFireStore()
                }
                Button("Dropped") {
                    listChoice = "dropped"
                    changeListFireStore()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    func listenToFireStore() { //should probably make this shorter
        
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("watching").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.watching]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.watching]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("completed").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.completed]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.completed]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("dropped").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.dropped]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.dropped]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("wantToWatch").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.wantToWatch]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.wantToWatch]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("recentlyDeleted").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.recentlyDeleted]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.recentlyDeleted]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
    
    func detectTappedList() { //Detects what list has been tapped and sets the collectionpath to what firestore document should be deleted
        for item in showList.lists[.wantToWatch]! {
            if item.show.name == showView.show.name {
                collectionPath = "wantToWatch"
            }
        }
        for item in showList.lists[.watching]! {
            if item.show.name == showView.show.name {
                collectionPath = "watching"
            }
        }
        for item in showList.lists[.completed]! {
            if item.show.name == showView.show.name {
                collectionPath = "completed"
            }
        }
        for item in showList.lists[.dropped]! {
            if item.show.name == showView.show.name {
                collectionPath = "dropped"
            }
        }
        for item in showList.lists[.recentlyDeleted]! {
            if item.show.name == showView.show.name {
                collectionPath = "recentlyDeleted"
            }
        }
    }
    func changeListFireStore() { //moves document to other collection + deletes the one in the previous list
        detectTappedList()
        var deleteList : [ApiShows.Returned] = [] //temporary list to deal with deleted documents from firestore
        guard let user = Auth.auth().currentUser else {return}
        
        do {
            //move document to selected collection in firestore
            _ = try db.collection("users").document(user.uid).collection(listChoice).addDocument(from: showView)
            //delete tapped document from firestore
            db.collection("users").document(user.uid).collection(collectionPath).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: ApiShows.Returned.self)
                        }
                        switch result  {
                        case .success(let show)  :
                            deleteList.removeAll()
                            deleteList.append(show)
                            for show in deleteList {
                                if show.show.name == showView.show.name {
                                    db.collection("users").document(user.uid).collection(collectionPath).document(document.documentID).delete()
                                }
                            }
                            case .failure(let error) : print("Error decoding item: \(error)") }
                    }
                }
            }
        } catch { print("catch error!") }
    }
}

struct selsectBackgroundBtns: View {
    @State private var rowColor = Color.white
    @State private var textColor = Color.black
    var body: some View {
        VStack {
            Button("Red") {
                //lägga func
                rowColor = Color.red
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Blue") {
                rowColor = Color.blue
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Black") {
                rowColor = Color.black
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Green") {
                rowColor = Color.green
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("White") {
                rowColor = Color.white
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Orange") {
                rowColor = Color.orange
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Purple") {
                rowColor = Color.purple
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}
func saveSettingsToFireStore(selectedTextColor: String, selectedRowBgColor: String) {
    guard let user = Auth.auth().currentUser else {return}
    db.collection("users").document(user.uid).collection("Settings").document("OverviewSettings").setData([
        "textColor": selectedTextColor,
        "rowBgColor": selectedRowBgColor,
    ])
    { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            //success
        }
    }
}
struct selectRowbtns: View {
    @State private var rowColor = Color.white
    @State private var textColor = Color.black
    var body: some View {
        VStack {
            Button("Black") {
                textColor = Color.black
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("White") {
                textColor = Color.white
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Blue") {
                textColor = Color.blue
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Red") {
                textColor = Color.red
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Purple") {
                textColor = Color.purple
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Green") {
                textColor = Color.green
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Orange") {
                textColor = Color.orange
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}

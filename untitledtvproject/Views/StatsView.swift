//
//  StatsView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-21.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseStorage

struct StatsView: View {
    let db = Firestore.firestore()
    
    //language lists
    @State var englishList : [ApiShows.ShowReturned] = []
    @State var swedishList : [ApiShows.ShowReturned] = []
    @State var koreanList : [ApiShows.ShowReturned] = []
    @State var thaiList : [ApiShows.ShowReturned] = []
    @State var chineseList : [ApiShows.ShowReturned] = []
    @State var japaneseList : [ApiShows.ShowReturned] = []
    @State var danishList : [ApiShows.ShowReturned] = []
    @State var norwegianList : [ApiShows.ShowReturned] = []
    @State var germanList : [ApiShows.ShowReturned] = []
    @State var frenchList : [ApiShows.ShowReturned] = []
    @State var dutchList : [ApiShows.ShowReturned] = []
    @State var polishList : [ApiShows.ShowReturned] = []
    @State var spanishList : [ApiShows.ShowReturned] = []
    @State var turkishList : [ApiShows.ShowReturned] = []
    @State var greekList : [ApiShows.ShowReturned] = []
    @State var allLanguages : [ApiShows.ShowReturned] = []
    //genre lists
    @State var dramaList : [ApiShows.ShowReturned] = []
    @State var comedyList : [ApiShows.ShowReturned] = []
    @State var scifiList : [ApiShows.ShowReturned] = []
    @State var horrorList : [ApiShows.ShowReturned] = []
    @State var crimeList : [ApiShows.ShowReturned] = []
    @State var adventureList : [ApiShows.ShowReturned] = []
    //network lists
    @State var syfyList : [ApiShows.ShowReturned] = []
    @State var hboList : [ApiShows.ShowReturned] = []
    @State var foxList : [ApiShows.ShowReturned] = []
    @State var cbsList : [ApiShows.ShowReturned] = []
    @State var comedyCentralList : [ApiShows.ShowReturned] = []
    @State var abcList : [ApiShows.ShowReturned] = []
    @State var bbcList : [ApiShows.ShowReturned] = []
    
    @State var showingLangWindow = false
    @State var showingGenreWindow = false
    @State var showingNetworkWindow1 = false
    @State var showingNetworkWindow2 = false
    
    var body: some View {
        VStack {
            Text("Statistics for Completed Shows")
            HStack { //languages graphs
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
                    .foregroundColor(.black)
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
                        let donut = Path { p in
                            p.addEllipse(in: CGRect(origin: .zero, size: size))
                            p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
                        }
                        context.clip(to: donut, style: .init(eoFill: true))
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
                    .foregroundColor(.black)
                    .alert("Individual split", isPresented: $showingLangWindow) { //showing counts instead of percentage for genres
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
            }
        }
        HStack { //second HStack - genres
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
                .foregroundColor(.black)
                .alert("Individual split", isPresented: $showingGenreWindow) { //change so it doesnt show empty language lists
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
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .aspectRatio(1.0, contentMode: .fit)
                Canvas { context, size in
                    let donut = Path { p in
                        p.addEllipse(in: CGRect(origin: .zero, size: size))
                        p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
                    }
                    context.clip(to: donut, style: .init(eoFill: true))
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
                .foregroundColor(.black)
                .alert("Individual split", isPresented: $showingGenreWindow) { //showing counts instead of percentage for genres
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
        .task { //read data from firestore to graphs
            DispatchQueue.main.async {
                listenToFireStore()
            }
        }
        HStack { //networks
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .aspectRatio(1.0, contentMode: .fit)
                Canvas { context, size in
                    let slices: [(Double, Color)] = [(Double(syfyList.count), .red),
                                                     (Double(hboList.count), .blue),
                                                     (Double(foxList.count), .green),
                                                     (Double(cbsList.count), .purple),
                                                     (Double(comedyCentralList.count), .teal),
                                                     (Double(abcList.count), .gray),
                                                     (Double(bbcList.count), .orange)]
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
                Button("Networks") {
                    showingNetworkWindow2 = true
                }
                .foregroundColor(.black)
                .alert("Percentage split", isPresented: $showingNetworkWindow2) {
                    VStack {
                        Button("Syfy: \(Double(syfyList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("HBO: \(Double(hboList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("FOX: \(Double(foxList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("CBS: \(Double(cbsList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("Comedy Central: \(Double(comedyCentralList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("ABC: \(Double(abcList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("BBC: \(Double(bbcList.count) / Double(allLanguages.count) * 100, specifier: "%.0f")%") {}
                        Button("Cancel", role: .cancel) { }
                    }
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .aspectRatio(1.0, contentMode: .fit)
                Canvas { context, size in
                    let donut = Path { p in
                        p.addEllipse(in: CGRect(origin: .zero, size: size))
                        p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
                    }
                    context.clip(to: donut, style: .init(eoFill: true))
                    let slices: [(Double, Color)] = [(Double(syfyList.count), .red),
                                                     (Double(hboList.count), .blue),
                                                     (Double(foxList.count), .green),
                                                     (Double(cbsList.count), .purple),
                                                     (Double(comedyCentralList.count), .teal),
                                                     (Double(abcList.count), .gray),
                                                     (Double(bbcList.count), .orange)]
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
                Button("Networks") {
                    showingNetworkWindow1 = true
                }
                .foregroundColor(.black)
                .alert("Individual split", isPresented: $showingNetworkWindow1) { //showing counts instead of percentage for genres
                    VStack {
                        Button("Syfy: \(syfyList.count)") {}
                        Button("HBO: \(hboList.count)") {}
                        Button("FOX: \(foxList.count)") {}
                        Button("CBS: \(cbsList.count)") {}
                        Button("Comedy Central: \(comedyCentralList.count)") {}
                        Button("ABC: \(abcList.count)") {}
                        Button("BBC: \(bbcList.count)") {}
                        Button("Cancel", role: .cancel) { }
                    }
                }
            }
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
                    Button(action: {
                        //do nothing
                    }) {
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
                        try document.data(as: ApiShows.ShowReturned.self)
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
                            //networks
                            if show.show.network?.name! == "Syfy" {
                                syfyList.append(show)
                            }
                            if show.show.network?.name! == "HBO" {
                                hboList.append(show)
                            }
                            if show.show.network?.name! == "FOX" {
                                foxList.append(show)
                            }
                            if show.show.network?.name! == "CBS" {
                                cbsList.append(show)
                            }
                            if show.show.network?.name! == "Comedy Central" {
                                comedyCentralList.append(show)
                            }
                            if show.show.network?.name! == "ABC" {
                                abcList.append(show)
                            }
                            if show.show.network?.name! == "BBC" {
                                bbcList.append(show)
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
        //genre lists
        dramaList.removeAll()
        comedyList.removeAll()
        horrorList.removeAll()
        scifiList.removeAll()
        crimeList.removeAll()
        adventureList.removeAll()
        //network lists
        syfyList.removeAll()
        hboList.removeAll()
        foxList.removeAll()
        cbsList.removeAll()
        comedyCentralList.removeAll()
        abcList.removeAll()
        bbcList.removeAll()
        
    }
}

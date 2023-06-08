//
//  OverView.swift
//  untitledtvproject
//
//  Created by Joel Pena Navarro on 2023-06-05.
//

import Foundation
import SwiftUI

import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct OverView : View {
    
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    let db = Firestore.firestore()
    
    @State var showingAlert = false
    
    @State var showingSettingsAlert = false
    @State var showRowBgColorAlert = false
    @State var showRowTextColorAlert = false
    
    @State private var rowColor = Color.white
    @State private var textColor = Color.black
    @State var selectedRowBgColor : String
    @State var selectedTextColor : String
    
    @State var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Want to watch")) {
                        ForEach(showList.lists[.wantToWatch]!, id: \.show.summary.hashValue) { returned in //show.summary.hashValue istället för ett unikt ID, summary är alltid unikt
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowView(showView: returned).background(Color.red)
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
                                AlertButtonsView(rowColor: $rowColor, textColor: $textColor)
                            }
                            .alert("Select row text color", isPresented: $showRowTextColorAlert) {
                                AlertButtonsView(rowColor: $rowColor, textColor: $textColor)
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
    func listenToSettingsFireStore() {
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
                        try document.data(as: ApiShows.ShowReturned.self)
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
                        try document.data(as: ApiShows.ShowReturned.self)
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
                        try document.data(as: ApiShows.ShowReturned.self)
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
                        try document.data(as: ApiShows.ShowReturned.self)
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
                        try document.data(as: ApiShows.ShowReturned.self)
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

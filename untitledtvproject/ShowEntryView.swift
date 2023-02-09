//
//  ShowEntryView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ShowEntryView : View {
    
    @State var show2 : ApiShows.Returned
    @State var name : String = ""
    @State var language : String = ""
    @State var summary: String = ""
    
    @State var image: ApiShows.Image?
    @State var type: String = ""
    @State var network: ApiShows.Network?
    @State var status: String = ""
    @State var premiered: String = ""
    
    @State var scale = 0.1
    
    @State var showPopUp = false
    
    @State var listChoice = ""
    
    @State var showingAlert = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image?.medium ?? ""))
                .padding(.top, 100)
                .padding(.bottom, -140)
                .ignoresSafeArea()
            Text("\(name)")
                .font(.largeTitle)
            Text("Summary: \(summary)")
                .padding(.top, -10)
                .padding(10)
                NavigationLink {
                    ShowEntryMoreView(show2: show2, name: show2.show.name, language: show2.show.language, summary: show2.show.summary, image: show2.show.image, type: show2.show.type, network: show2.show.network, status: show2.show.status, premiered: show2.show.premiered, rating: show2.show.rating)
                } label: {
                    Text("Show more information")
                }
            Spacer()
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        NavigationLink(destination: OverView()) {
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
                            showPopUp = true
                        }) {
                            Image("plus.app.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .scaleEffect(scale)
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image("square.and.pencil.circle.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                        Spacer()
                        NavigationLink(destination: ProfileView()) {
                            Image("person.crop.circle.fill")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                    }
                }
            }
            .confirmationDialog("Add to what list?", isPresented: $showPopUp, actions: {
                VStack {
                    HStack {
                        Button("Want to watch") {
                            listChoice = "Want to watch"
                            saveToFireStore()
                        }
                        Button("Watching") {
                            listChoice = "Watching"
                            saveToFireStore()
                        }
                    }
                    HStack {
                        Button("Completed") {
                            listChoice = "Completed"
                            saveToFireStore()
                        }
                        Button("Dropped") {
                            listChoice = "Dropped"
                            saveToFireStore()
                        }
                    }
                }
            })
            .alert("Show added!", isPresented: $showingAlert) {
                Button("Go it!", role: .cancel) { }
            }
            .navigationBarBackButtonHidden(false)
        }
        .background(Color(.systemGray6))
        .onAppear() {
            setContent()
            _ = Animation.easeInOut(duration: 1)

            withAnimation {
                scale = 1
            }
        }
    }
    func saveToFireStore() {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else {return}
        do {
            _ = try db.collection("users").document(user.uid).collection(listChoice).addDocument(from: show2)
            showingAlert = true
        } catch {
            print("error!")
            }
        }
    func setContent() {
        
        summary = summary.replacingOccurrences(of: "<p>", with: "")
        summary = summary.replacingOccurrences(of: "</p>", with: "")
        summary = summary.replacingOccurrences(of: "<b>", with: "")
        summary = summary.replacingOccurrences(of: "</b>", with: "")
        summary = summary.replacingOccurrences(of: "<i>", with: "")
        summary = summary.replacingOccurrences(of: "</i>", with: "")

/*
        guard let url1 = URL(string: show2.show.image?.medium ?? "") else { print("error url not correct emil"); return }
        do {
            //let data = try Data(contentsOf: url1)
            image?.medium = url1.absoluteString
        } catch {
            print("error, no img from url \(url1)")
        }*/
/*
        if let show = show {
            name = show.name
            language = show.language
            summary = show.summary
        }*/
    }
}

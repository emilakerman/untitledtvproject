//
//  ShowEntryMoreView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-06.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ShowEntryMoreView: View {
    
    var show2 : ApiShows.Returned
    var show : ShowEntry? = nil
    @State var name : String = ""
    @State var language : String = ""
    @State var summary: String = ""
    @State var image: ApiShows.Image?
    @State var type: String = ""
    //@State var genres: [String]?
    @State var network: ApiShows.Network?
    @State var status: String = ""
    @State var premiered: String = ""
    
    @State var scale = 0.1
    
    @State var showPopUp = false
    
    @State var listChoice = ""
    
    var body: some View {
    VStack {
        HStack {
            AsyncImage(url: URL(string: image?.medium ?? ""))
            VStack {
                Text("\(name)")
                Text("\(language)")
                Text("\(type)")
                //Text("\(genres)")
                Text("\(network?.name ?? "")")
                Text("\(status)")
                Text("\(premiered)")
            }
        }
        Text("\(summary)")
            .padding(10)
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
        .navigationBarBackButtonHidden(true)
    }
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
        } catch {
                print("Document successfully written!")
            }
        }
    func setContent() {
        summary = summary.replacingOccurrences(of: "<p>", with: "")
        summary = summary.replacingOccurrences(of: "</p>", with: "")
        summary = summary.replacingOccurrences(of: "<b>", with: "")
        summary = summary.replacingOccurrences(of: "</b>", with: "")
        summary = summary.replacingOccurrences(of: "<i>", with: "")
        summary = summary.replacingOccurrences(of: "</i>", with: "")
    }
}
/*
struct ShowEntryMoreView_Previews: PreviewProvider {
    static var previews: some View {
        ShowEntryMoreView()
    }
}*/

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
    @State var rating: ApiShows.Rating
    
    @State var scale = 0.1
    
    @State var showPopUp = false
    
    @State var listChoice = ""
    
    @State var showingAlert = false

    var body: some View {
    VStack {
            AsyncImage(url: URL(string: image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
            .padding(.top, 100)
            .padding(.bottom, -140)
            .ignoresSafeArea()
            Text("\(name)")
                .font(.largeTitle)
        List {
            HStack {
                Text("Language")
                Spacer()
                Text("\(language)")
            }
            HStack {
                Text("Type")
                Spacer()
                Text("\(type)")
            }
            HStack {
                Text("Network")
                Spacer()
                Text("\(network?.name ?? "")")
            }
            HStack {
                Text("Status")
                Spacer()
                Text("\(status)")
            }
            HStack {
                Text("Premiered")
                Spacer()
                Text("\(premiered)")
            }
            HStack {
                Text("Average rating")
                Spacer()
                Text("\(rating.average ?? 0.0, specifier: "%.1f")")
            }
        }
        .background(.clear)
        .scrollContentBackground(.hidden)
        .padding(.top, -30)
        Spacer()
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
                    NavigationLink(destination: ProfileView(selectedUserName: "", userName: "")) {
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
                        listChoice = "wantToWatch"
                        saveToFireStore()
                    }
                    Button("Watching") {
                        listChoice = "watching"
                        saveToFireStore()
                    }
                }
                HStack {
                    Button("Completed") {
                        listChoice = "completed"
                        saveToFireStore()
                    }
                    Button("Dropped") {
                        listChoice = "dropped"
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
}
/*
struct ShowEntryMoreView_Previews: PreviewProvider {
    static var previews: some View {
        ShowEntryMoreView()
    }
}*/

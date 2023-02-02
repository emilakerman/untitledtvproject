//
//  ProfileView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-30.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                Text("Name:")
            }
            Spacer()
            Text("Other information")
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(newColor)
                    .aspectRatio(1.0, contentMode: .fit)
                RoundedRectangle(cornerRadius: 20)
                    .fill(newColor)
                    .aspectRatio(1.0, contentMode: .fit)
            }
            .padding(10)
            .padding(.bottom, -20)
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(newColor)
                    .aspectRatio(1.0, contentMode: .fit)
                RoundedRectangle(cornerRadius: 20)
                    .fill(newColor)
                    .aspectRatio(1.0, contentMode: .fit)
            }
            .padding(10)
            .padding(.bottom, -20)
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(newColor)
                    .aspectRatio(1.0, contentMode: .fit)
                RoundedRectangle(cornerRadius: 20)
                    .fill(newColor)
                    .aspectRatio(1.0, contentMode: .fit)
            }
            .padding(10)
            Spacer()
        }
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
                        
                    }) {
                        Image("plus.app")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image("square.and.pencil.circle.fill")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
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
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

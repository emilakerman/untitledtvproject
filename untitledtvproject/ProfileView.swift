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
        
    var newColor = Color(red: 243 / 255, green: 246 / 255, blue: 255 / 255)
    
    var user = Auth.auth().currentUser
    
    @State var signedIn = true
    @State var wantToSignUp = false
    @State var createdAccount = false
        
    var body: some View {
        if !signedIn {
            LoginView(signedIn: $signedIn, wantToSignUp: $wantToSignUp, createdAccount: $createdAccount)
        } else {
            VStack {
                HStack {
                    Image("defaultprofilepic") //will be user image + (if no profile pic, then use this default one) --- >>>user.photoURL<<<
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .padding(.top, 10)
                    Text(user?.email ?? "") //maybe change to username
                    Spacer()
                    Button(action: {
                        logOut()
                    }) {
                        Image("info.circle")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    .padding(10)
                    .padding(.top, 10)
                }
                Spacer()
                Text("Another way of seeing your data")
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
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            //Auth.auth().currentUser == nil
            signedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }/*
    func getUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
          // ...
        }
    }*/
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

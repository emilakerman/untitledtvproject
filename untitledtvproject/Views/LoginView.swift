//
//  LogView.swift
//  untitledtvproject
//
//  Created by Joel Pena Navarro on 2023-06-05.
//

import Foundation
import SwiftUI

import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

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

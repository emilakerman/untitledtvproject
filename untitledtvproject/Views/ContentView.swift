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


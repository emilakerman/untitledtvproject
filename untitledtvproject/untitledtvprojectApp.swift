//
//  untitledtvprojectApp.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct untitledtvprojectApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
            //LoginView(signedIn: false)
        }
    }
}

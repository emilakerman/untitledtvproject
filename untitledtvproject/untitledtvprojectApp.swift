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
    
//    private var rowColor = Color.white
//    private var textColor = Color.black
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            //ContentView()
            SplashScreenView()
//                .environmentObject(rowColor)
//                .environmentObject(textColor)
            //StatsView()
        }
    }
}

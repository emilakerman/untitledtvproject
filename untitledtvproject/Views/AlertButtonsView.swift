//
//  AlertButtonsView.swift
//  untitledtvproject
//
//  Created by Joel Pena Navarro on 2023-06-06.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct AlertButtonsView: View {
    @Binding var rowColor : Color
    @Binding var textColor : Color
    let db = Firestore.firestore()
    
    
    var body: some View {
        VStack {
            Button("Red") {
                rowColor = Color.red
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Blue") {
                rowColor = Color.blue
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Black") {
                rowColor = Color.black
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Green") {
                rowColor = Color.green
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("White") {
                rowColor = Color.white
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Orange") {
                rowColor = Color.orange
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Purple") {
                rowColor = Color.purple
                saveSettingsToFireStore(selectedTextColor: "\(textColor)", selectedRowBgColor: "\(rowColor)")
            }
            Button("Cancel", role: .cancel) { }
        }
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
    
}

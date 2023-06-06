//
//  RowView.swift
//  untitledtvproject
//
//  Created by Joel Pena Navarro on 2023-06-05.
//

import Foundation
import SwiftUI

import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

struct RowView : View {
    var showView : ApiShows.ShowReturned
    @State var showingAlert = false
    @State var listChoice = ""
    @State var collectionPath = ""
    
    let db = Firestore.firestore()
    @StateObject var showList = ShowList()
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                .onTapGesture {
                    showingAlert = true
                    listenToFireStore()
                    //fireStoreManager.listenToFireStore()
                }
            Text(showView.show.name)
        }
        .alert("Move to what list?", isPresented: $showingAlert) {
            VStack {
                Button("Want to watch") {
                    listChoice = "wantToWatch"
                    changeListFireStore()
                }
                Button("Watching") {
                    listChoice = "watching"
                    changeListFireStore()
                }
                Button("Completed") {
                    listChoice = "completed"
                    changeListFireStore()
                }
                Button("Dropped") {
                    listChoice = "dropped"
                    changeListFireStore()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    func listenToFireStore() { //should probably make this shorter
        
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("watching").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.watching]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.ShowReturned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.watching]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("completed").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.completed]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.ShowReturned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.completed]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("dropped").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.dropped]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.ShowReturned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.dropped]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("wantToWatch").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.wantToWatch]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.ShowReturned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.wantToWatch]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        db.collection("users").document(user.uid).collection("recentlyDeleted").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                showList.lists[.recentlyDeleted]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.ShowReturned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        showList.lists[.recentlyDeleted]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
    func detectTappedList() { //Detects what list has been tapped and sets the collectionpath to what firestore document should be deleted
        for item in showList.lists[.wantToWatch]! {
            if item.show.name == showView.show.name {
                collectionPath = "wantToWatch"
            }
        }
        for item in showList.lists[.watching]! {
            if item.show.name == showView.show.name {
                collectionPath = "watching"
            }
        }
        for item in showList.lists[.completed]! {
            if item.show.name == showView.show.name {
                collectionPath = "completed"
            }
        }
        for item in showList.lists[.dropped]! {
            if item.show.name == showView.show.name {
                collectionPath = "dropped"
            }
        }
        for item in showList.lists[.recentlyDeleted]! {
            if item.show.name == showView.show.name {
                collectionPath = "recentlyDeleted"
            }
        }
    }
    func changeListFireStore() { //moves document to other collection + deletes the one in the previous list
        detectTappedList()
        var deleteList : [ApiShows.ShowReturned] = [] //temporary list to deal with deleted documents from firestore
        guard let user = Auth.auth().currentUser else {return}
        
        do {
            //move document to selected collection in firestore
            _ = try db.collection("users").document(user.uid).collection(listChoice).addDocument(from: showView)
            //delete tapped document from firestore
            db.collection("users").document(user.uid).collection(collectionPath).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: ApiShows.ShowReturned.self)
                        }
                        switch result  {
                        case .success(let show)  :
                            deleteList.removeAll()
                            deleteList.append(show)
                            for show in deleteList {
                                if show.show.name == showView.show.name {
                                    db.collection("users").document(user.uid).collection(collectionPath).document(document.documentID).delete()
                                }
                            }
                            case .failure(let error) : print("Error decoding item: \(error)") }
                    }
                }
            }
        } catch { print("catch error!") }
    }
}

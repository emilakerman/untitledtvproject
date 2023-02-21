//
//  FireStoreManager.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-21.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class FireStoreManager : ObservableObject {
    
    var showList = ShowList()
    let db = Firestore.firestore()
    
    func listenToFireStore() {
        
        guard let user = Auth.auth().currentUser else {return}
        
        db.collection("users").document(user.uid).collection("watching").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                self.showList.lists[.watching]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        self.showList.lists[.watching]?.append(show)
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
                self.showList.lists[.completed]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        self.showList.lists[.completed]?.append(show)
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
                self.showList.lists[.dropped]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        self.showList.lists[.dropped]?.append(show)
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
                self.showList.lists[.wantToWatch]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        self.showList.lists[.wantToWatch]?.append(show)
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
                self.showList.lists[.recentlyDeleted]?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: ApiShows.Returned.self)
                    }
                    switch result  {
                    case .success(let show)  :
                        self.showList.lists[.recentlyDeleted]?.append(show)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
}

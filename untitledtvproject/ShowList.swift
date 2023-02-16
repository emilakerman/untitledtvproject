//
//  ShowList.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

enum Status {
    case shows
    case wantToWatch
    case watching
    case completed
    case dropped
    case recentlyDeleted
}
class ShowList : ObservableObject {
    
    @Published var lists = [Status : [ApiShows.Returned]]()
    
    var deleteList : [ApiShows.Returned] = []

    init() {
        lists[.shows] = [ApiShows.Returned]()
        lists[.wantToWatch] = [ApiShows.Returned]()
        lists[.watching] = [ApiShows.Returned]()
        lists[.dropped] = [ApiShows.Returned]()
        lists[.completed] = [ApiShows.Returned]()
        lists[.recentlyDeleted] = [ApiShows.Returned]()
    }
    func delete(indexSet: IndexSet, status: Status) {
        for index in indexSet {
            if let item = lists[status]?[index] {
                lists[status]?.remove(atOffsets: indexSet)
                lists[.recentlyDeleted]?.append(item)

                let db = Firestore.firestore()
                guard let user = Auth.auth().currentUser else {return}

                db.collection("users").document(user.uid).collection("\(status)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let result = Result {
                                try document.data(as: ApiShows.Returned.self)
                            }
                            switch result  {
                            case .success(let show)  :
                                self.deleteList.removeAll()
                                self.deleteList.append(show)
                                for show in self.deleteList {
                                    if show.show.name == item.show.name {
                                        db.collection("users").document(user.uid).collection("\(status)").document(document.documentID).delete()
                                        do {
                                            var showEntryView = ShowEntryView(show2: show)
                                            _ = try db.collection("users").document(user.uid).collection("recentlyDeleted").addDocument(from: showEntryView.show2)
                                        } catch {
                                            print("error!")
                                        }
                                    }
                                }
                            case .failure(let error) :
                                print("Error decoding item: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}

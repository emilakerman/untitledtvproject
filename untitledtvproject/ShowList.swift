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
            }
        }
    }
    /*
    func unDelete(indexSet: IndexSet, status: Status) {
        for index in indexSet {
            if let item = lists[status]?[index] {
                lists[status]?.remove(atOffsets: indexSet)
                lists[.recentlyDeleted]?.append(item)
            }
        }
    }
    */
}

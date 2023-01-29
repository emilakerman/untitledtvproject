//
//  ShowList.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation

enum Status {
    case shows
    case wantToWatch
    case watching
    case completed
    case dropped
    case recentlyDeleted
}
class ShowList : ObservableObject {
    
    @Published var lists = [Status : [ShowEntry]]()
    
    init() {
        lists[.shows] = [ShowEntry]()
        lists[.wantToWatch] = [ShowEntry]()
        lists[.watching] = [ShowEntry]()
        lists[.dropped] = [ShowEntry]()
        lists[.completed] = [ShowEntry]()
        lists[.recentlyDeleted] = [ShowEntry]()
        
        addMockData()
    }
    func addMockData() {
         lists[.shows]?.append(ShowEntry(name: "Farmen", language: "Swedish", summary: ""))
         lists[.wantToWatch]?.append(ShowEntry(name: "Farmen", language: "Swedish", summary: ""))
        
         lists[.shows]?.append(ShowEntry(name: "Game of Thrones", language: "English",  summary: ""))
         lists[.watching]?.append(ShowEntry(name: "Game of Thrones", language: "English", summary: ""))
        
         lists[.shows]?.append(ShowEntry(name: "Family Guy", language: "English", summary: ""))
         lists[.watching]?.append(ShowEntry(name: "Family Guy", language: "English", summary: ""))
         
         lists[.shows]?.append(ShowEntry(name: "South Park", language: "English", summary: ""))
         lists[.watching]?.append(ShowEntry(name: "South Park", language: "English", summary: ""))
         
         lists[.shows]?.append(ShowEntry(name: "Archer", language: "English", summary: ""))
         lists[.completed]?.append(ShowEntry(name: "Archer", language: "English", summary: ""))
         
         lists[.shows]?.append(ShowEntry(name: "Chuck", language: "English", summary: ""))
         lists[.dropped]?.append(ShowEntry(name: "Chuck", language: "English", summary: ""))
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

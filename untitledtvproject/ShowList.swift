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
         lists[.shows]?.append(ShowEntry(title: "Farmen", rating: 0, image: 0, description: "", seasons: 2, episodes: 12))
         lists[.wantToWatch]?.append(ShowEntry(title: "Farmen", rating: 0, image: 0, description: "", seasons: 2, episodes: 12))
        
         lists[.shows]?.append(ShowEntry(title: "Game of Thrones", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
         lists[.watching]?.append(ShowEntry(title: "Game of Thrones", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
        
         lists[.shows]?.append(ShowEntry(title: "Family Guy", rating: 0, image: 0, description: "", seasons: 1, episodes: 67))
         lists[.watching]?.append(ShowEntry(title: "Family Guy", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
         
         lists[.shows]?.append(ShowEntry(title: "South Park", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
         lists[.watching]?.append(ShowEntry(title: "South Park", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
         
         lists[.shows]?.append(ShowEntry(title: "Archer", rating: 5, image: 0, description: "", seasons: 9, episodes: 672))
         lists[.completed]?.append(ShowEntry(title: "Archer", rating: 5, image: 0, description: "", seasons: 9, episodes: 672))
         
         lists[.shows]?.append(ShowEntry(title: "Chuck", rating: 0, image: 0, description: "", seasons: 6, episodes: 88))
         lists[.dropped]?.append(ShowEntry(title: "Chuck", rating: 0, image: 0, description: "", seasons: 6, episodes: 88))
    }
    
    func delete(indexSet: IndexSet, status: Status) {
        for index in indexSet {
            if let item = lists[status]?[index] {
                lists[status]?.remove(atOffsets: indexSet)
                lists[.recentlyDeleted]?.append(item)
            }
        }
    }
}

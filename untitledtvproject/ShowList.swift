//
//  ShowList.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation

class ShowList : ObservableObject {
    
    @Published var shows = [ShowEntry]() //all in here
    @Published var wantToWatch = [ShowEntry]()
    @Published var watching = [ShowEntry]()
    @Published var completed = [ShowEntry]()
    @Published var dropped = [ShowEntry]()
    @Published var recentlyDeleted = [ShowEntry]()
    
    init() {
        addMockData()
    }
    func addMockData() {
        shows.append(ShowEntry(title: "Farmen", rating: 0, image: 0, description: "", seasons: 2, episodes: 12))
        wantToWatch.append(ShowEntry(title: "Farmen", rating: 0, image: 0, description: "", seasons: 2, episodes: 12))
        
        shows.append(ShowEntry(title: "Game of Thrones", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
        watching.append(ShowEntry(title: "Game of Thrones", rating: 0, image: 0, description: "", seasons: 5, episodes: 67))
        
        shows.append(ShowEntry(title: "Archer", rating: 5, image: 0, description: "", seasons: 9, episodes: 672))
        completed.append(ShowEntry(title: "Archer", rating: 5, image: 0, description: "", seasons: 9, episodes: 672))
        
        shows.append(ShowEntry(title: "Chuck", rating: 0, image: 0, description: "", seasons: 6, episodes: 88))
        dropped.append(ShowEntry(title: "Chuck", rating: 0, image: 0, description: "", seasons: 6, episodes: 88))
    }
}

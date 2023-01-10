//
//  ShowEntry.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation

struct ShowEntry : Identifiable, Equatable {
    let id = UUID()
    
    let title : String
    var rating : Int //user sets this (should translate to stars out of 5)
    let image : Int
    let description : String
    var seasons : Int
    var episodes : Int
    
    enum status {
        case wantToWatch
        case watching
        case completed
        case dropped
    }
    
    
    func add() { //add to an array - "Want to watch/Watching/Completed"
        
    }
    func delete(indexSet: IndexSet) { //remove from the array - move to here. but maybe also add the show to a new "recently deleted" list? so you can undo deleted items
        
    }
    func move() { //remove from current array and add to other array. eg, from "Want to watch" to -> "Watching"
        
    }
    func rate() { //user rates the tv show after it has been added to "Completed"
        
    }
}

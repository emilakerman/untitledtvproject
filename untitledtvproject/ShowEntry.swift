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
    
   
    
    
    func add() { //add to an array - "Want to watch/Watching/Completed"
        
    }
    func move() { //remove from current array and add to other array. eg, from "Want to watch" to -> "Watching"
        
    }
    func rate() { //user rates the tv show after it has been added to "Completed"
        
    }
}

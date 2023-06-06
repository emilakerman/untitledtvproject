//
//  ShowEntry.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI

struct ShowEntry: Identifiable, Codable {
    
    var id = UUID()
    
    var name: String
    var language: String
    var summary: String
    var image: URL?

    
    /*
    func add() { //add to an array - "Want to watch/Watching/Completed"
        
    }
    func move() { //remove from current array and add to other array. eg, from "Want to watch" to -> "Watching"
        
    }
    func rate() { //user rates the tv show after it has been added to "Completed"
        
    }*/
}

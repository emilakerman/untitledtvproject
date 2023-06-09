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

    

}

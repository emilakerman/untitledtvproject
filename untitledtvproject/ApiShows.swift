//
//  ApiShows.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-17.
//

import Foundation

class ApiShows : ObservableObject {
            
    //create empty array for the data
    @Published var showArray: [Returned] = []
        
    //search array for api
    @Published var searchArray = [Returned]()
                
    struct Returned: Codable, Identifiable {
        var id : UUID?
        var show: Show
    }
    enum SearchScope: String, CaseIterable {
        case name
    }
    struct Show: Codable{
        var name: String
        var language: String
        var summary: String
        var image: Image?
        
        enum CodingKeys: String, CodingKey {
            case name
            case language
            case summary
            case image
        }
    }
    struct Image: Codable {
        var medium: String?
    }
}

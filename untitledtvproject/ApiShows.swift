//
//  ApiShows.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-17.
//

import Foundation
import FirebaseFirestoreSwift

class ApiShows : ObservableObject {
            
    //create empty array for the data
    @Published var showArray : [Returned] = []
        
    //search array for api
    @Published var searchArray : [Returned] = []
    init() {
        searchArray = [Returned]()
    }
    struct Returned: Codable, Identifiable {
        var id : UUID?
        var show: Show
    }
    enum SearchScope: String, CaseIterable {
        case name
    }
    struct Show: Codable, Identifiable {
        @DocumentID var id: String? = UUID().uuidString
        var name: String
        var language: String
        var summary: String
        var image: Image?
        var type: String
        var network: Network?
        var status: String
        var premiered: String
        var rating: Rating?
        var genres: [String]?
    
        enum CodingKeys: String, CodingKey {
            case name
            case language
            case summary
            case image
            case type
            case network
            case status
            case premiered
            case rating
            case genres
        }
    }
    struct Rating: Codable {
        var average: Double?
    }
    struct Network: Codable {
        var name: String?
    }
    struct Image: Codable {
        var medium: String?
    }
}

//
//  ApiShows.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-17.
//

import Foundation

class ApiShows : ObservableObject {
    //this variable should be the input of the user during search, or the last part of it at least
    var urlString = "https://api.tvmaze.com/search/shows?q=alien"
    
    //create empty array for the data
    @Published var showArray: [Returned] = []
    
    //new list to add names
    @Published var newList = [String]()
    
    struct Returned: Codable, Identifiable {
        //var score: Double
        var id : UUID?
        var show: Show
    }
    struct Show: Codable {
        var name: String
        //var language: String
        //var genres: String
        //var premiered: String
        //var runtime: Int
        //var status: String
    }
    
    func getData(completed: @escaping ()->()) {
        print("trying to access the url \(urlString)")
        
        //Create url
        guard let url = URL(string: urlString) else {
            print("Error could not create url from \(urlString)")
            completed()
            return
        }
        //create urlsession
        let session = URLSession.shared
        //get data with .dataTask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            //deal with the data
            do {
                //the returned data is added to showArray
                self.showArray = try JSONDecoder().decode([Returned].self, from: data!)
                //adds the name of the downloaded object to a new list
                for item in self.showArray {
                    self.newList.append(item.show.name)
                }
            } catch {
                print("json error \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}

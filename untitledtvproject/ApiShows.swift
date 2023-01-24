//
//  ApiShows.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-17.
//

import Foundation

class ApiShows : ObservableObject {
        
    var urlString = "https://api.tvmaze.com/search/shows?q=alien"
    
    //create empty array for the data
    @Published var showArray: [Returned] = []
    
    //new list to add names
    @Published var newList = [String]()
    //one more list with object? name+language
    //@Published var newList2 : Array = []
    @Published var newList2: [Returned] = []
    
    struct Returned: Codable, Identifiable {
        //var score: Double
        var id : UUID?
        var show: Show
    }

    //denna måste se ut exakt som json, inga egna variabler
    struct Show: Codable, Equatable {
        //kanske ta bort och byta med ShowEntry, eller tvärt emot
        var name: String
        var language: String
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
                self.newList.removeAll()
                self.newList2.removeAll()
                for item in self.showArray {
                    self.newList.append(item.show.name) //for names only
                    self.newList2.append(item)
                }
                //let i = self.newList2[1].show.language ///goood !!!
                //print(i)
                //print(self.newList2[1].show.name) ///yepppp
                //print(self.showArray[1].show.name)
                for item in self.showArray {
                    print(item.show.name)
                }
                
            } catch {
                print("catch: json error \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}

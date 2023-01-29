//
//  ApiShows.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-17.
//

import Foundation

class ApiShows : ObservableObject {
        
    var urlString = "https://api.tvmaze.com/search/shows?q=resident+alien"
    
    //create empty array for the data
    @Published var showArray: [Returned] = []
    
    //new list to add names (test)
    @Published var newList = [String]()
        
    //new search thing
    @Published var searchArray = [Returned]()
    
    @Published var orderedNoDuplicates : [Returned] = []
            
    struct Returned: Codable, Identifiable {
        var id : UUID? //needs to be UUID? but many shows gets the ID = nil which is an issue
        var show: Show
    }
    struct Show: Codable, Identifiable {
        var id : String = UUID().uuidString
        //var id = UUID()
        var name: String
        var language: String
        var summary: String
        var image: Image?

        /*
        var genres: [String]?
        var image: Image?
         */
        
        private enum CodingKeys: String, CodingKey {
            case name
            case language
            case summary
            case image
        }
    }
    struct Image: Codable {
        var medium: String?
    }
    //???hmmmm från david
    /*
    func trytry() {
        var result : [Returned] = []
        
        for stuff in showArray {
            if stuff.show.name == searchGlobal {
                result.append(stuff)
            }
            print("result list: \(result.count)")
        }
    }
     */
    /*
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
                //self.showArray.removeAll()
                self.showArray = try JSONDecoder().decode([Returned].self, from: data!)
                
                //adds the name of the downloaded object to a new list
                /*
                self.newList.removeAll()
                for item in self.showArray {
                    self.newList.append(item.show.name) //for names only
                }*/
                 
                //let i = self.newList2[1].show.language ///goood !!!
                //print(i)
                //print(self.newList2[1].show.name) ///yepppp
                //print(self.showArray[1].show.name)
                /*
                for item in self.showArray {
                    print(item.show.name)
                }*/
                //print(self.showArray.count)
                
            } catch {
                print("catch: json error \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
     */
}

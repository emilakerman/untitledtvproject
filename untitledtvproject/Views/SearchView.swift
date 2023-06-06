//
//  SearchView.swift
//  untitledtvproject
//
//  Created by Joel Pena Navarro on 2023-06-05.
//

import Foundation
import SwiftUI

struct SearchView : View {
    
    @StateObject var showList = ShowList()
    @State private var searchText = ""
    
    var filteredMessages: [ApiShows.ShowReturned] {
        return (showList.lists[.searchList]?.filter { $0.show.name.localizedCaseInsensitiveContains(searchText) })!
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredMessages, id: \.show.summary.hashValue) { returned in
                        NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                            Text(returned.show.name)
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a show")
                .onSubmit(of: .search, getData)
                .disableAutocorrection(true)
                .toolbar {
                    NavigationLink(destination: ExploreView()) { Text("Explore") }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack {
                            NavigationLink(destination: OverView(selectedRowBgColor: "", selectedTextColor: "")) {
                                Image("house.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .isDetailLink(false)
                            Spacer()
                            NavigationLink(destination: StatsView()) {
                                
                                Image("redstats")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image("magnifyingglass.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image("square.and.pencil.circle.fill_grey")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            Spacer()
                            NavigationLink(destination: ProfileView(selectedUserName: "", userName: "")) {
                                Image("person.crop.circle.fill")
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            }
                            .isDetailLink(false)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    func getData() {
        
        searchText = searchText.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.tvmaze.com/search/shows?q=\(searchText)"
        
        print("trying to access the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error could not create url from \(urlString)")
            return
        }
        searchText = searchText.replacingOccurrences(of: "%20", with: " ") //problem med house of the dragon "-" "-" something
        
        showList.lists[.searchList]?.removeAll()
        
        //create urlsession
        let session = URLSession.shared
        //get data with .dataTask
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            //deal with the data
            do {
                showList.lists[.searchList]? = try JSONDecoder().decode([ApiShows.ShowReturned].self, from: data!)
            } catch {
                print("catch: json error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

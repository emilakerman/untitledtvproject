//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI

enum SearchScope: String, CaseIterable {
    case name
}

struct ContentView: View {
    
    @State var searchScope = SearchScope.name
    
    //@State var searchName = "alien"
    
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    @State var searchText = ""
    @State var emptyList = [String]()
    /*
    @State var searchResults: [ApiShows.Returned] {
        if searchText.isEmpty {
            return apiShows.showArray
        } else {
            var result : [ApiShows.Returned] = []
            
            for stuff in apiShows.showArray {
                if stuff.show.name == searchText {
                    result.append(stuff)
                }
                
                
                //return result.Returned.show.name.filter { $0.localizedCaseInsensitiveContains(apiShows.searchGlobal) }
                //return apiShows.showArray.name.filter { $0.name.contains(searchText) }
            }
        }
    }*/
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section { //search works with api
                        ForEach(filteredMessages) { returned in
                            NavigationLink(destination: ShowEntryView(name: returned.show.name, language: returned.show.language, summary: returned.show.summary)) {
                                //Text(returned.show.name)
                                RowTest(showTest: returned)
                            }
                        }
                    }
                   .searchable(text: $searchText)
                   .searchScopes($searchScope) {
                       ForEach(SearchScope.allCases, id: \.self) { scope in
                           Text(scope.rawValue.capitalized)
                       }
                   }
                   .onSubmit(of: .search, runSearch)
                   .onChange(of: searchScope) { _ in runSearch() }
                   .disableAutocorrection(true)
                    /*
                    Section { /// searchable version
                        ForEach(apiShows.showArray) { returned in
                            NavigationLink(destination: ShowEntryView(name: returned.show.name, language: returned.show.language, summary: returned.show.summary)) {
                                //Text(returned.show.name)
                                RowTest(showTest: returned)
                            }
                        }
                    }
                    //.searchable(text: $searchText)
                    Section(header: Text("api section")) { /// duplicate results???
                        ForEach(apiShows.showArray) { returned in
                            NavigationLink(destination: ShowEntryView(name: returned.show.name, language: returned.show.language, summary: returned.show.summary)) {
                                //Text(returned.show.name)
                                RowTest(showTest: returned)
                            }
                        }
                    }*/
                    Section(header: Text("Want to watch")) {
                        ForEach(showList.lists[.wantToWatch]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .wantToWatch)
                        }
                    }
                    Section(header: Text("Watching")) {
                        ForEach(showList.lists[.watching]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .watching)
                        }
                    }
                    Section(header: Text("Completed")) {
                        ForEach(showList.lists[.completed]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .completed)
                        }
                    }
                    Section(header: Text("Dropped")) {
                        ForEach(showList.lists[.dropped]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .dropped)
                        }
                    }
                    .onAppear() {
                        apiShows.getData {}
                    }
                    Section(header: Text("Recently deleted")) {
                        ForEach(showList.lists[.recentlyDeleted]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language, summary: show.summary)) {
                                RowView(show: show)
                            }
                        }
                    }
                    
                }
            }
        }
    }
    var filteredMessages: [ApiShows.Returned] {
        if searchText.isEmpty {
            return apiShows.searchArray.filter { $0.show.name.localizedCaseInsensitiveContains("") } //so its empty at start
        } else {
            return apiShows.searchArray.filter { $0.show.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    func runSearch() {
        Task {
            guard let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(searchText)") else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            apiShows.searchArray = try JSONDecoder().decode([ApiShows.Returned].self, from: data)
        }
    }
}
struct RowTest : View {
    var showTest : ApiShows.Returned
    
    var body: some View {
        HStack {
            Text(showTest.show.name)
        }
    }
}
struct RowView : View {
    var show : ShowEntry
    
    var body: some View {
        HStack {
            Text(show.name)
        }
    }
}
/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */

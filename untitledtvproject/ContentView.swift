//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchName = "alien"
    
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    @State var searchText : String
    @State var emptyList = [String]()
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return emptyList
        } else {
            return apiShows.newList.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                Form {/*
                    Section(header: Text("Search")) {
                        ForEach(searchResults, id: \.self) { show in
                            NavigationLink(show) {
                                ApiShowEntryView(show: show.name)
                            }
                        }
                    }
                    .searchable(text: $searchText)*/
                    Section(header: Text("apitest")) {
                        ForEach(apiShows.newList, id: \.self) { show in
                            NavigationLink(destination: ShowEntryView(name: show)) {
                                Text(show)
                            }
                        }
                    }/*
                    Section(header: Text("showArrayAPI")) {
                        ForEach(apiShows.showArray, id: \.self) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language)) {
                                Text(show)
                            }
                        }
                    }*/
                    Section(header: Text("Want to watch")) {
                        ForEach(showList.lists[.wantToWatch]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .wantToWatch)
                        }
                    }
                    Section(header: Text("Watching")) {
                        ForEach(showList.lists[.watching]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .watching)
                        }
                    }
                    Section(header: Text("Completed")) {
                        ForEach(showList.lists[.completed]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .completed)
                        }
                    }
                    Section(header: Text("Dropped")) {
                        ForEach(showList.lists[.dropped]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .dropped)
                        }
                    }
                    Section(header: Text("API FETCH")) {
                        ForEach(apiShows.newList, id: \.self) { show in
                            Text(show)
                        }
                    }
                    .onAppear() {
                        apiShows.getData {}
                    }
                    Section(header: Text("Recently deleted")) {
                        ForEach(showList.lists[.recentlyDeleted]!) { show in
                            NavigationLink(destination: ShowEntryView(name: show.name, language: show.language)) {
                                RowView(show: show)
                            }
                        }
                    }
                }
            }
        }
    }
}
struct RowTest : View {
    var showTest : ApiShows.Show
    
    var body: some View {
        HStack {
            Text(showTest.name)
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

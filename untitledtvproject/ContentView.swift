//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    @State var searchText : String
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return apiShows.newList
        } else {
            return apiShows.newList.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink { //fixa så man kan välja vilken lista man ska lägga till serien i
                            Text(name)
                        } label: {
                            Text(name)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            NavigationView {
                Form {
                    Section(header: Text("Want to watch")) {
                        ForEach(showList.lists[.wantToWatch]!) { show in
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .wantToWatch)
                        }
                    }
                    Section(header: Text("Watching")) {
                        ForEach(showList.lists[.watching]!) { show in
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .watching)
                        }
                    }
                    Section(header: Text("Completed")) {
                        ForEach(showList.lists[.completed]!) { show in
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            showList.delete(indexSet: indexSet, status: .completed)
                        }
                    }
                    Section(header: Text("Dropped")) {
                        ForEach(showList.lists[.dropped]!) { show in
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
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
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                                RowView(show: show)
                            }
                        }
                    }
                }
            }
        }
    }
}
struct RowView : View {
    var show : ShowEntry
    
    var body: some View {
        HStack {
            Text(show.title)
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

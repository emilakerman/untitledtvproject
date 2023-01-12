//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var showList = ShowList()
    
    var body: some View {
        VStack {
        NavigationView {
            Form {
                Section(header: Text("Want to watch")) {
                    ForEach(showList.wantToWatch) { show in
                        NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                            RowView(show: show)
                        }
                    }
                    .onDelete() { indexSet in
                        delete(indexSet: indexSet)
                    }
                }
                Section(header: Text("Watching")) {
                    ForEach(showList.watching) { show in
                        NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                            RowView(show: show)
                        }
                    }
                    .onDelete() { indexSet in
                        delete(indexSet: indexSet)
                    }
                }
            Section(header: Text("Completed")) {
                    ForEach(showList.completed) { show in
                        NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                            RowView(show: show)
                        }
                    }
                    .onDelete() { indexSet in
                        delete(indexSet: indexSet)
                    }
                }
            Section(header: Text("Dropped")) {
                        ForEach(showList.dropped) { show in
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                                RowView(show: show)
                            }
                        }
                        .onDelete() { indexSet in
                            delete(indexSet: indexSet)
                        }
                    }
                Section(header: Text("Recently deleted")) {
                        ForEach(showList.recentlyDeleted) { show in
                            NavigationLink(destination: ShowEntryView(show: show, title: show.title, seasons: show.seasons, episodes: show.episodes)) {
                                RowView(show: show)
                            }
                        }
                    }
                }
            }
        }
    }
    func delete(indexSet: IndexSet) { //move to ShowEntry struct, when its deleted from the "shows" list, then it should be removed from the other lists too, but added to "deleted" list
        for index in indexSet {
            let item = showList.dropped[index]
            showList.dropped.remove(atOffsets: indexSet)
            showList.recentlyDeleted.append(item)
        }
    }
    func goToInfoPage() {

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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
            Image(systemName: "play.tv")
                .padding()
            Text("Want to watch")
                .font(.system(size: 22))
            NavigationView {
                List() {
                    ForEach(showList.wantToWatch) { show in
                        NavigationLink(destination: ShowEntryView(show: show)) {
                            RowView(show: show)
                        }
                    }
                }
            }
            Text("Watching")
                .font(.system(size: 22))
            NavigationView {
                List() {
                    ForEach(showList.watching) { show in
                        NavigationLink(destination: ShowEntryView(show: show)) {
                            RowView(show: show)
                        }
                    }
                }
            }
            Text("Completed")
                .font(.system(size: 22))
            NavigationView {
                List() {
                    ForEach(showList.completed) { show in
                        NavigationLink(destination: ShowEntryView(show: show)) {
                            RowView(show: show)
                        }
                    }
                }
            }
            Text("Dropped")
                .font(.system(size: 22))
            NavigationView {
                List() {
                    ForEach(showList.dropped) { show in
                        NavigationLink(destination: ShowEntryView(show: show)) {
                            RowView(show: show)
                        }
                    }
                    .onDelete() { indexSet in
                        delete(indexSet: indexSet)
                    }
                }
            }
        }
    }
func delete(indexSet: IndexSet) { //move to ShowEntry struct, when its deleted from the "shows" list, then it should be removed from the other lists too, but added to "deleted" list
        showList.shows.remove(atOffsets: indexSet)
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

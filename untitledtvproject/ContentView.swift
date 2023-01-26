//
//  ContentView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import SwiftUI

struct ContentView: View {
    
    //@State var searchName = "alien"
    
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
        
    @State var searchText : String
    @State var emptyList = [String]()
    
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return emptyList
        } else {
            return apiShows.newList.filter { $0.localizedCaseInsensitiveContains(searchText) }
            //return apiShows.showArray.name.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                Form {/*
                    Section { //WRONG!!!!!!!!!!!
                        ForEach(searchResults, id: \.self) { show in
                            NavigationLink {
                                ShowEntryView(name: show)
                            } label: {
                                Text(show)
                            }
                        }
                        .searchable(text: $searchText)
                    }*/
                    List(apiShows.showArray) { returned in
                        NavigationLink(destination: ShowEntryView(name: returned.show.name, language: returned.show.language)) {
                            RowTest(showTest: returned)
                        }
                    }
                    Section(header: Text("showArrayAPI")) { /// duplicate results???
                        ForEach(apiShows.showArray) { returned in
                            NavigationLink(destination: ShowEntryView(name: returned.show.name, language: returned.show.language)) {
                                Text(returned.show.name)
                                //RowTest(showTest: returned)
                            }
                        }
                    }
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

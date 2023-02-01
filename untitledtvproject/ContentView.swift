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
        
    @StateObject var showList = ShowList()
    @StateObject var apiShows = ApiShows()
    
    @State var searchText = ""
    
    @State var orderedNoDuplicates1 : [ApiShows.Returned] = []
    
    @State var singleItemList : [ApiShows.Returned] = []

    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section { //search works with api
                        ForEach(filteredMessages) { returned in
                            NavigationLink(destination: ShowEntryView(show2: returned, name: returned.show.name, language: returned.show.language, summary: returned.show.summary, image: returned.show.image)) {
                                RowTest(showTest: returned)
                            }
                        }
                    }
                   .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                   .searchScopes($searchScope) {
                       ForEach(SearchScope.allCases, id: \.self) { scope in
                           Text(scope.rawValue.capitalized)
                       }
                   }
                   .onSubmit(of: .search, runSearch)
                   .onChange(of: searchScope) { _ in runSearch() }
                   .disableAutocorrection(true)
                    /*
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
                    }*/
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            HStack {
                                Button(action: {
                                    //do nothing
                                }) {
                                    Image("house.fill")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image("redstats")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image("plus.app")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image("square.and.pencil.circle.fill")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                                Spacer()
                                NavigationLink(destination: ProfileView()) {
                                    Image("person.crop.circle.fill")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    var filteredMessages: [ApiShows.Returned] {
        if searchText.isEmpty {
            return singleItemList.filter { $0.show.name.localizedCaseInsensitiveContains("") } //so its empty at start
        } else {
            return singleItemList.filter { $0.show.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    func runSearch() {
        Task {
            
            //searchText = searchText.replacingOccurrences(of: " ", with: "%20")
            
            guard let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(searchText)") else { return }

            let (data, _) = try await URLSession.shared.data(from: url)
            apiShows.searchArray = try JSONDecoder().decode([ApiShows.Returned].self, from: data)
            orderedNoDuplicates1 = NSOrderedSet(array: apiShows.searchArray).map({ $0 as! ApiShows.Returned })
            singleItemList.removeAll()
            singleItemList.append(orderedNoDuplicates1[0])
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

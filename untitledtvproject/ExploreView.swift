//
//  ExploreView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-22.
//

import SwiftUI

struct ExploreView: View {
    @State var exploreList : [ApiShows.Show] = []
    
    @State var hboList : [ApiShows.Show] = []
    @State var foxList : [ApiShows.Show] = []
    @State var abcList : [ApiShows.Show] = []
    @State var cbsList : [ApiShows.Show] = []
    @State var itv1List : [ApiShows.Show] = []
    @State var nbcList : [ApiShows.Show] = []
    @State var showTimeList : [ApiShows.Show] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("🔥 Top Shows on HBO")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(hboList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("📺 Top Shows on FOX")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(foxList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("🙉 Top Shows on CBS")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(cbsList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("😉 Top Shows on ABC")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(abcList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
                Text("❤️ Top Shows on NBC")
                    .font(.system(size: 20))
                    .frame(width: 380, alignment: .leading)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(nbcList, id: \.id) { show in
                                AsyncImage(url: URL(string: show.image?.medium ?? "https://i.imgur.com/e3AEk4W.png"))
                                    .frame(width: 140, height: 210)
                            }
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
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
                    NavigationLink(destination: SearchView()) {
                        
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
        .onAppear() {
            getData()
        }
    }
    func getData() {
        
        let urlStringAll = "https://api.tvmaze.com/shows"
        
        print("trying to access the url \(urlStringAll)")
        
        guard let url = URL(string: urlStringAll) else {
            print("Error could not create url from \(urlStringAll)")
            return
        }
        
        exploreList.removeAll()
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            //deal with the data
            do {
                exploreList = try JSONDecoder().decode([ApiShows.Show].self, from: data!)
                distributeData()
            } catch {
                print("catch: json error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    func distributeData() {
        for item in exploreList {
            if item.network?.name! == "HBO" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        hboList.append(item)
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "FOX" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        foxList.append(item)
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "ABC" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        abcList.append(item)
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "NBC" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        nbcList.append(item)
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "CBS" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        cbsList.append(item)
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "Showtime" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        showTimeList.append(item)
                    }
                }
            }
        }
        for item in exploreList {
            if item.network?.name! == "ITV1" {
                if item.rating?.average != nil {
                    if (item.rating?.average)! >= 6.0 {
                        itv1List.append(item)
                    }
                }
            }
        }
    }
}


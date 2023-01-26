//
//  ShowEntryView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI

struct ShowEntryView : View {
    
    //var show : ApiShows.Show? = nil
    var show : ShowEntry? = nil
    @State var name : String = ""
    @State var language : String = ""
    /*
    @State var summary: String?
    @State var genres: [String]?
    @State var image: Image?
     */
    
    
    /*
    @State var seasons : Int
    @State var episodes : Int
     */

    
    var body: some View {
        VStack {
            Text("Title: \(name)")
            Text("Language: \(language)")
            //Text("Seasons: \(seasons)")
            //Text("Episodes: \(episodes)")
        }
        .onAppear() {
            setContent()
        }
    }
    func setContent() {
        if let show = show {
            name = show.name
            language = show.language
            /*
            summary = show.summary
            genres = show.genres
            image = show.image
             */
            
            
            
            //seasons = show.seasons
            //episodes = show.episodes
        }
    }
}

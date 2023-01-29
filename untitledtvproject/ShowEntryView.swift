//
//  ShowEntryView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI

struct ShowEntryView : View {
    
    
    var show2 : ApiShows.Show? = nil
    var show : ShowEntry? = nil
    @State var name : String = ""
    @State var language : String = ""
    @State var summary: String = ""
    @State var image: Image?
    /*
    @State var genres: [String]?
    @State var image: Image?
     */
    
    
    /*
    @State var seasons : Int
    @State var episodes : Int
     */

    
    var body: some View {
        VStack {
            //URL(string: show2?.image?.original ?? "")
            Image("testimage")
            Text("Title: \(name)")
            Text("Language: \(language)")
                .padding()
            Text("Summary: \(summary)")
                .padding(10)
            Button("Add to list") {
                
            }
        }
        .onAppear() {
            setContent()
        }
        
    }
    func setContent() {
        summary = summary.replacingOccurrences(of: "<p>", with: "")
        summary = summary.replacingOccurrences(of: "</p>", with: "")
        summary = summary.replacingOccurrences(of: "<b>", with: "")
        summary = summary.replacingOccurrences(of: "</b>", with: "")


        if let show = show {
            name = show.name
            language = show.language
            summary = show.summary
            //image = show.image
            /*
            genres = show.genres
            image = show.image
             */
            
            
            
            //seasons = show.seasons
            //episodes = show.episodes
        }
    }
}

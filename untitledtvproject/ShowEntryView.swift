//
//  ShowEntryView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI

struct ShowEntryView : View {
    
    var show : ShowEntry? = nil
    @State var title : String = ""
    @State var seasons : Int
    @State var episodes : Int

    
    var body: some View {
        VStack {
            Text("Title: \(title)")
            Text("Seasons: \(seasons)")
            Text("Episodes: \(episodes)")
        }
        .onAppear() {
            setContent()
        }
    }
    func setContent() {
        if let show = show {
            title = show.title
            seasons = show.seasons
            episodes = show.episodes
        }
    }
}

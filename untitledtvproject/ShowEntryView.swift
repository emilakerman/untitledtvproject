//
//  ShowEntryView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-01-10.
//

import Foundation
import SwiftUI

struct ShowEntryView : View {
    
    
    var show2 : ApiShows.Returned
    var show : ShowEntry? = nil
    @State var name : String = ""
    @State var language : String = ""
    @State var summary: String = ""
    
    @State var image: ApiShows.Image?
    //@State var image: String = ""
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
            //Image(image?.original ?? "")
            AsyncImage(url: URL(string: image?.medium ?? ""))
                //.frame(maxWidth: 100, maxHeight: 300)
            //AsyncImage(url: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/4/11403.jpg"))
            //Image("\(image?.original)")
            //Image(systemName: "person.fill")
            //    .data(url: URL(string: image?.original ?? "") ?? "")
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
        
        guard let url1 = URL(string: show2.show.image?.medium ?? "") else { print("error url not correct emil"); return }
        print("this urL: \(url1)")
        //image?.original = url1.absoluteString
        do {
            let data = try Data(contentsOf: url1)
            //image = Image(url: URL(string: "\(data)"))
            //image = Image("\(data)")
            //print("this url: \(data)")
            //image = url1
            image?.medium = url1.absoluteString
            print("the data variable: \(data)")
            print("the image::::: \(image?.medium)")
        } catch {
            print("error, no img from url \(url1)")
        }

        if let show = show {
            name = show.name
            language = show.language
            summary = show.summary
            image?.medium = url1.absoluteString
            /*
            genres = show.genres
            image = show.image
             */
            //seasons = show.seasons
            //episodes = show.episodes
        }
    }
}
extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

//
//  EmptyView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-20.
//

import SwiftUI


struct EmptyView: View {
    
    //this view is just here to fix/deal with a bug I had with an empty row always being displayed under the searchbar
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var emptyListFix : [String] = ["dummy string"]
    
    var gray1 = Color(UIColor.systemGray6)
    var black = Color(UIColor.black)
    
    var body: some View {
        ZStack {
            ForEach(emptyListFix, id:\.hashValue) { cell in
                Text("")
            }
            if colorScheme == .light {
                gray1
                    .frame(width: 550, height: 1000)
            } else {
                black
                    .frame(width: 550, height: 1000)
            }
        }
        .ignoresSafeArea()
    }
}


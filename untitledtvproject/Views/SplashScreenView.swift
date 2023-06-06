//
//  SplashScreenView.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-15.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    //progress bar
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "play.tv")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        Text("TV Tracker")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.white.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear() {
                        withAnimation(.easeIn(duration: 2.0)) {
                            self.size = 1.5
                            self.opacity = 1.0
                        }
                    }
                    /*
                    ProgressView("Downloading…", value: downloadAmount, total: 100)
                        .onReceive(timer) { _ in
                            if downloadAmount < 100 {
                                downloadAmount += 2
                            }
                        }*/
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

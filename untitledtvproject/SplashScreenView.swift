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
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "tv.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.purple)
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

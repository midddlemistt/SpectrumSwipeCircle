//
//  LoadingView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isLoading = false
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            Image("MenuBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x:-40)
                .edgesIgnoringSafeArea(.all)

            
            VStack {
                Image("LoadingIcon")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 100, height: 100)
                       .rotationEffect(.degrees(rotation))
                       .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                       .onAppear {
                           withAnimation {
                               self.rotation += 360
                           }
                       }
                       .offset(y: 100)
                
                 
                   Image("Loading")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 150, height: 150)
                       .offset(y: 35)
            }
        }
        .onAppear {
            // Симуляция загрузки в течение 2 секунд
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isLoading = true
            }
        }
        .fullScreenCover(isPresented: $isLoading) {
            MenuView()
        }
    }
}

#Preview {
    LoadingView()
}

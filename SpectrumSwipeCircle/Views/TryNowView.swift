//
//  TryNowView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI

struct TryNowView: View {
    var score: Int
    var highScore: Int
    var onRetry: () -> Void
    @StateObject private var viewModel = GameViewModel()
    @Binding var showGameView: Bool
    
    
    var body: some View {
        ZStack {
            Image("CoinsBG")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x:-40)
            VStack {
                Image("TryNow")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 450, height: 400)
                    .offset(y:50)
                
                Image("GameFrame")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .overlay(
                        VStack {
                            Text("Score: \(score)")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Best: \(highScore)")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    )
                
                
                HStack{
                    
                    Button(action: onRetry) {
                        Image("Retry")
                    }
                    
                    Button(action: {
                        showGameView = false
                    }) {
                        Image("Menu")
                    }
                }
            }
        }
        .padding()
        .background(
            Image("GameBlackout")
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
    

//#Preview {
//    GameView()
//}

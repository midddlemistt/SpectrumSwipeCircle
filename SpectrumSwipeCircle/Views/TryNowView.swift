//
//  TryNowView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI

struct TryNowView: View {
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
                
                
                HStack{
                    
                    Button(action: onRetry) {
                        Image("Retry")
                            .padding()
                    }
                    
                    Button(action: {
                        showGameView = false
                    }) {
                        Image("Menu")
                            .padding()
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

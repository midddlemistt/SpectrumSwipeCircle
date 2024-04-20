//
//  GameView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @Binding var showGameView: Bool
    @State private var ballOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Image("GameBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x:-50)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                // Счет
                Image("GameFrame")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
                    .overlay(
                        VStack {
                            Text("Score: \(viewModel.score)")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    )
                
                // Игровое поле
                ZStack {
                                    // Круг с разделенными частями
                                    Image(viewModel.circleImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 385, height: 385)
                                    
                                    // Шарик в центре
                                    Image(viewModel.ballImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(ballOffset)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    withAnimation {
                                                        updateBallOffset(with: value.translation)
                                                    }
                                                }
                                                .onEnded { value in
                                                    withAnimation {
                                                        resetBallOffset()
                                                    }
                                                    viewModel.handleSwipe(value)
                                                }
                                        )
                                }
            }
            
            if viewModel.showYouWin {
                YouWinView(score: viewModel.score, highScore: viewModel.highScore, onContinue: {
                    viewModel.continueGame()
                }, onCollectPrize: {
                    viewModel.collectPrize()
                }, showGameView: $showGameView)
            }
            
            if viewModel.showTryNow {
                TryNowView(onRetry: {
                    viewModel.startNewGame()
                }, showGameView: $showGameView)
            }
        }
        .onAppear {
            viewModel.startNewGame()
//            resetBallPosition()
        }
    }
    
    private func updateBallOffset(with translation: CGSize) {
            var newOffset = translation
            
            // Ограничение смещения шарика в пределах круга
            let maxOffset: CGFloat = 120
            if newOffset.width > maxOffset {
                newOffset.width = maxOffset
            } else if newOffset.width < -maxOffset {
                newOffset.width = -maxOffset
            }
            if newOffset.height > maxOffset {
                newOffset.height = maxOffset
            } else if newOffset.height < -maxOffset {
                newOffset.height = -maxOffset
            }
            
            ballOffset = newOffset
        }
        
        private func resetBallOffset() {
            ballOffset = .zero
        }}

#Preview {
    MenuView()
}

//
//  GameViewModel.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import Foundation
import SwiftUI
import AVFoundation
import UIKit

class GameViewModel: ObservableObject {
    @Published var score = 0
    @Published var highScore = 0
    @Published var ballImage = "RedBall"
    @Published var circleImage = "Circle1"
    @Published var showYouWin = false
    @Published var showTryNow = false
    @Published var currentCircleIndex = 0
    @ObservedObject private var settingsManager = SettingsManager()
    
    private var audioPlayer: AVAudioPlayer?
    private var timeLimit: TimeInterval = 1.5
    private var timer: Timer?
    
    private let ballImages = ["RedBall", "GreenBall", "BlueBall", "YellowBall"]
    private let circleImages = ["Circle1", "Circle2", "Circle3", "Circle4"]
    
    func startNewGame() {
        score = 0
        showYouWin = false
        showTryNow = false
        updateCircleAndBall()
        startTimer()
        loadHighScore()
    }
    
    func handleSwipe(_ value: DragGesture.Value) {
        let direction = getSwipeDirection(value)
        
        if isSwipeCorrect(direction) {
            score += 1
            playSound(sound: "SwipeBall" )
            vibrate()
            
            if score % 10 == 0 {
                playSound(sound: "WinSound")
                showYouWin = true
                stopTimer()
            } else {
                updateCircleAndBall()
                resetTimer()
            }
        } else {
            showTryNow = true
            playSound(sound: "FailSound")
            vibrate()
            stopTimer()
            saveHighScore()
        }
    }
    
    func continueGame() {
        showYouWin = false
        updateCircleAndBall()
        startTimer()
    }
    
    func collectPrize() {
        print("Collect prize tapped")
        // Здесь можно добавить логику для сбора приза
        showYouWin = false
    }
    
    private func getSwipeDirection(_ value: DragGesture.Value) -> SwipeDirection {
        let deltaX = value.location.x - value.startLocation.x
        let deltaY = value.location.y - value.startLocation.y
        
        if deltaX > 0 && deltaY < 0 {
            return .topRight
        } else if deltaX < 0 && deltaY < 0 {
            return .topLeft
        } else if deltaX < 0 && deltaY > 0 {
            return .bottomLeft
        } else {
            return .bottomRight
        }
    }
    
    private func isSwipeCorrect(_ direction: SwipeDirection) -> Bool {
        switch (circleImage, ballImage, direction) {
        case ("Circle1", "RedBall", .topLeft),
            ("Circle2", "RedBall", .topRight),
            ("Circle3", "RedBall", .bottomRight),
            ("Circle4", "RedBall", .bottomLeft),
            
            ("Circle1", "GreenBall", .bottomRight),
            ("Circle2", "GreenBall", .bottomLeft),
            ("Circle3", "GreenBall", .topLeft),
            ("Circle4", "GreenBall", .topRight),
            
            ("Circle1", "BlueBall", .bottomLeft),
            ("Circle2", "BlueBall", .topLeft),
            ("Circle3", "BlueBall", .topRight),
            ("Circle4", "BlueBall", .bottomRight),
            
            ("Circle1", "YellowBall", .topRight),
            ("Circle2", "YellowBall", .bottomRight),
            ("Circle3", "YellowBall", .bottomLeft),
            ("Circle4", "YellowBall", .topLeft):
            return true
        default:
            return false
        }
    }
    
    func updateCircleAndBall() {
           let randomCircleIndex = Int.random(in: 0..<circleImages.count)
           let randomBallIndex = Int.random(in: 0..<ballImages.count)
           
           withAnimation {
               circleImage = circleImages[randomCircleIndex]
               ballImage = ballImages[randomBallIndex]
           }
       }
    
//    private func shuffleImages() {
//        let randomBallIndex = Int.random(in: 0..<ballImages.count)
//        let randomCircleIndex = Int.random(in: 0..<circleImages.count)
//        
//        ballImage = ballImages[randomBallIndex]
//        circleImage = circleImages[randomCircleIndex]
//    }
    
    private func resetTimer() {
        stopTimer()
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: false) { _ in
            self.showTryNow = true
            self.stopTimer()
            self.saveHighScore()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func playSound(sound: String) {
           guard settingsManager.isSoundEnabled else { return }
           
           guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
           
           do {
               audioPlayer = try AVAudioPlayer(contentsOf: url)
               audioPlayer?.play()
           } catch {
               print("Failed to play sound: \(error)")
           }
       }
    
    private func vibrate() {
           guard settingsManager.isVibrationEnabled else { return }
           
           let generator = UIImpactFeedbackGenerator(style: .medium)
           generator.impactOccurred()
       }
    
    private func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    private func saveHighScore() {
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScore")
        }
    }
    
    
}

enum SwipeDirection {
    case topLeft, topRight, bottomLeft, bottomRight
}




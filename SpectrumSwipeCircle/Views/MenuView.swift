//
//  MenuView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI
import SafariServices

struct MenuView: View {
    @State private var showNotification = true
    @State private var showSettings = false
    @State private var isSoundEnabled = true
    @State private var isVibrationEnabled = true
    @StateObject private var settingsManager = SettingsManager()
    @State private var showSafari = false
    @State private var safariURL: URL?
    @StateObject private var gameViewModel = GameViewModel()
    @State private var showGameView = false

    var body: some View {
        ZStack {
            Image("MenuBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x:-40)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 380, height: 300)
                    .padding(.top, 70)
                
                Button(action: {
                    showGameView = true
                }) {
                    Image("PlayButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 270, height: 100)
                }
                
                HStack {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image("SettingsLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 100)
                    }
                    
                    Button(action: {
                        openPrivacyPolicy()
                    }) {
                        Image("PrivacyPolicy")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 100)
                        
                    }
                    
                }
            }

            if showNotification {
                NotificationView(isPresented: $showNotification)
            }

            if showSettings {
                SettingsView(isPresented: $showSettings, settingsManager: settingsManager)
                    }
        }
        .fullScreenCover(isPresented: $showGameView) {
                    GameView(showGameView: $showGameView)
                }
        .onAppear {
            showNotification = true
        }
        .sheet(isPresented: $showSafari) {
            if let url = safariURL {
                SafariView(url: url)
            }
        }
    }

    private func openPrivacyPolicy() {
        guard let url = URL(string: "https://rooh.co") else { return }
        safariURL = url
        showSafari = true
    }
}



#Preview {
    MenuView()
}

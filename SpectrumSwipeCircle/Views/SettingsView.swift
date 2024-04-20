//
//  SettingsView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isPresented: Bool
    @ObservedObject var settingsManager: SettingsManager
    
    var body: some View {
        ZStack{
            ZStack {
                Image("SettingsCoins")
                    .resizable()
                    .scaledToFit()
                    .offset(y:-150)
                    .frame(width: 200, height: 200)
                
                Image("SettingsFrame")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: 300, height: 300)
                VStack {
                    Image("Settings")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .padding()
                        .offset(y:45)
                    
                    HStack {
                        Image(settingsManager.isSoundEnabled ? "SoundON" : "SoundOFF")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                settingsManager.isSoundEnabled.toggle()
                            }
                            .padding()
                        
                       
                        
                        Image(settingsManager.isVibrationEnabled ? "VibroON" : "VibroOFF")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                settingsManager.isVibrationEnabled.toggle()
                            }
                            .padding()
                    }
                    .offset(y:10)
                    
                    Button(action: {
                        settingsManager.save()
                        isPresented = false
                    }) {
                        Text("Close")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                        
                    }
                    .offset(y:15)
                    .padding(.top)
                }
            }
            .padding()
            .background(
                Image("MenuBlackout")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.75)
            )
            .aspectRatio(contentMode: .fit)
            
        }
    }
}



#Preview {
    MenuView()
}


//
//  SettingsManager.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI
import AVFoundation
import AudioToolbox

class SettingsManager: ObservableObject {
    @Published var isSoundEnabled = true {
        didSet {
            // Включение/выключение звука в зависимости от значения isSoundEnabled
            do {
                try AVAudioSession.sharedInstance().setCategory(
                    isSoundEnabled ? .playback : .ambient,
                    mode: .default,
                    options: []
                )
            } catch {
                print("Failed to set audio session category.")
            }
        }
    }
    
    @Published var isVibrationEnabled = true {
        didSet {
            // Включение/выключение вибрации в зависимости от значения isVibrationEnabled
            if isVibrationEnabled {
                // Включить вибрацию
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            } else {
                // Выключить вибрацию (нет прямого способа отключить вибрацию)
            }
        }
    }
    
     init() {
           // Загрузка сохраненных настроек из UserDefaults
           isSoundEnabled = UserDefaults.standard.bool(forKey: "isSoundEnabled")
           isVibrationEnabled = UserDefaults.standard.bool(forKey: "isVibrationEnabled")
       }
       
       func save() {
           // Сохранение текущих настроек в UserDefaults
           UserDefaults.standard.set(isSoundEnabled, forKey: "isSoundEnabled")
           UserDefaults.standard.set(isVibrationEnabled, forKey: "isVibrationEnabled")
       }
}

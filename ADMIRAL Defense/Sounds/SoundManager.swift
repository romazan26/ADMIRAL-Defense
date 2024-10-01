//
//  SoundManager.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import AVKit
import SwiftUI

enum SoundOption: String{
    case menuMusic
    case gameMusic
    case buy
    case damage
    case bomb
    case buttonClick
}

final class SoundManager {
    @AppStorage("volumeSound") var volumeSound: String?
    
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            player?.volume = Float(volumeSound ?? "1") ?? 1
        }catch let error{
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

final class MusicManager {
    @AppStorage("volumeMusic") var volumeMusic: String?
    
    static let instance = MusicManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            player?.volume = Float(volumeMusic ?? "1") ?? 1
        }catch let error{
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

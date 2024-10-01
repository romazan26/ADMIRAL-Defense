//
//  MainVoewModel.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI
import CoreData

final class MainViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @AppStorage("volumeSound") var volumeSound: String?
    @AppStorage("volumeMusic") var volumeMusic: String?
    
    @Published var levels: [GameLevel] = []
    @Published var simpleLevel: GameLevel!
    
    @Published var isPresentSettings: Bool = false
    
    init() {
        getData()
        if levels.isEmpty {
            for _ in 0..<8 {
                addLevel()
            }
        }
    }
    
    //MARK: - Sound
    func soundMute() {
        if SoundManager.instance.player?.volume != 0 {
            volumeSound = "0"
            SoundManager.instance.player?.volume = 0
        }else{
            volumeSound = "1"
            SoundManager.instance.player?.volume = 1
        }
        
    }
    func musicMute() {
        if MusicManager.instance.player?.volume != 0 {
            volumeMusic = "0"
            MusicManager.instance.player?.volume = 0
        }else{
            volumeMusic = "1"
            MusicManager.instance.player?.volume = 1
        }
        
    }
    
    //MARK: Next level
    func nextLevel() {
        let nextlevel = simpleLevel.number + 1
        
            let request = NSFetchRequest<GameLevel>(entityName: "GameLevel")
            do {
                levels = try manager.context.fetch(request)
                if let level = levels.first(where: {$0.number == nextlevel}){
                    simpleLevel = level
                }
            }catch let error {
                print(error)
            }
        
        saveData()
    }
    
    //MARK: Comleted level
    func completedLevel(score: Int16) {
        let nextlevel = simpleLevel.number + 1
        if score > 0 {
            let request = NSFetchRequest<GameLevel>(entityName: "GameLevel")
            do {
                levels = try manager.context.fetch(request)
                let level = levels.first(where: {$0.number == nextlevel})
                level?.isOpen = true
                let levelold = levels.first(where: {$0.id == simpleLevel.id})
                if levelold?.score ?? 0 < score {
                    levelold?.score = score
                }
                
            }catch let error {
                print(error)
            }
        }
        saveData()
    }
    
    //MARK: - Add data
    func addLevel(){
        let newLevel = GameLevel(context: manager.context)
        newLevel.number = Int16(levels.count + 1)
        newLevel.score = 0
        newLevel.isOpen = levels.isEmpty ? true : false
        newLevel.time = Double(30 * newLevel.number)
        saveData()
    }
    
    //MARK: - Get data
    func getData() {
        let request = NSFetchRequest<GameLevel>(entityName: "GameLevel")
        do {
            levels = try manager.context.fetch(request)
        }catch let error {
            print(error)
        }
    }
    
    //MARK: - Save data
    func saveData() {
        levels.removeAll()
        manager.save()
        getData()
    }
}

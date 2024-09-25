//
//  MainVoewModel.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import Foundation
import CoreData

final class MainViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var levels: [GameLevel] = []
    
    init() {
        getData()
        if levels.isEmpty {
            for _ in 0..<8 {
                addLevel()
            }
        }
    }
    
    //MARK: - Add data
    func addLevel(){
        let newLevel = GameLevel(context: manager.context)
        newLevel.number = Int16(levels.count + 1)
        newLevel.score = 0
        newLevel.isOpen = levels.isEmpty ? true : false
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

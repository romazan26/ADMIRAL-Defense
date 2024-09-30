//
//  ShipsViewModel.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//

import CoreData
import SwiftUI

final class ShipsViewModel: ObservableObject {
    @AppStorage("money") var money: Int?
    let manager = CoreDataManager.instance
    
    @Published var ships: [Ship] = []
    @Published var simpleMoney: Int = 0
    @Published var simpleShip: ShipEnum = .ship1
    
    init(){
        fetchShips()
        if ships.isEmpty{
            startAddShip()
        }
        simpleMoney = money ?? 0
    }
    
    //MARK: - Buy ship
    func buyShip(){
        if simpleMoney  >= simpleShip.price{
            simpleMoney -= simpleShip.price
            let request = NSFetchRequest<Ship>(entityName: "Ship")
            do{
                ships = try manager.context.fetch(request)
                let ship = ships.first(where: {$0.number == simpleShip.number})
                ship?.isOpen = true
            }catch let error{
                print("Error fetching ships: \(error)")
            }
            saveShip()
            money = simpleMoney
        }
    }
    
    //MARK: - Get full info of ship
    func getFullHealth() -> Int{
        let ship = ships.first(where: {$0.number == simpleShip.number})
        return (Int(ship?.addHeath ?? 0) + simpleShip.helth)
    }
    func getFullShield() -> Int{
        let ship = ships.first(where: {$0.number == simpleShip.number})
        return (Int(ship?.addSheld ?? 0) + simpleShip.shield)
    }
    func getFullExtraPoints() -> Int{
        let ship = ships.first(where: {$0.number == simpleShip.number})
        return (Int(ship?.addPoints ?? 0) + simpleShip.extraPonts)
    }
    
    //MARK: - getIsOpen
    func getIsOpen() -> Bool{
        let ship = ships.first(where: {$0.number == simpleShip.number})
        return ship?.isOpen ?? false
        
    }
    
    //MARK: - Returm image ship
    func getSimpleShip(number: Int){
        switch number {
        case 1: simpleShip = .ship1
            case 2: simpleShip = .ship2
            case 3: simpleShip = .ship3
            case 4: simpleShip = .ship4
            case 5: simpleShip = .ship5
        default:
            break
        }
    }
    //MARK: - Add data
    func addOneShip(ship: ShipEnum){
        let newShip = Ship(context: manager.context)
        newShip.number = Int16(ship.number)
        if ships.isEmpty{
            newShip.isOpen = true
        }else{
            newShip.isOpen = false
        }
        saveShip()
    }
    
    func startAddShip(){
           for ship in ShipEnum.allCases{
            addOneShip(ship: ship)
        }
    }
    
    //MARK: - save data
    func saveShip(){
        ships.removeAll()
        manager.save()
        fetchShips()
    }
    
    //MARK: get data
    func fetchShips() {
        let request = NSFetchRequest<Ship>(entityName: "Ship")
        do{
            ships = try manager.context.fetch(request)
        }catch let error{
            print("Error fetching ships: \(error)")
        }
    }
}

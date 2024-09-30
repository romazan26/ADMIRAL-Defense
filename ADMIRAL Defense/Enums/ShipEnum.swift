//
//  ShipEnum.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//
import SwiftUI

enum ShipEnum: CaseIterable, Identifiable {
    case ship1
    case ship2
    case ship3
    case ship4
    case ship5
    
    var number: Int {
        switch self {
        case .ship1: return 1
        case .ship2: return 2
        case .ship3: return 3
        case .ship4: return 4
        case .ship5: return 5
        }
    }
    
    var helth: Int {
        switch self {
        case .ship1: return 20
        case .ship2: return 40
        case .ship3: return 60
        case .ship4: return 80
        case .ship5: return 100
        }
    }
    
    var shield: Int {
        switch self {
        case .ship1: return 0
        case .ship2: return 30
        case .ship3: return 50
        case .ship4: return 70
        case .ship5: return 100
        }
    }
    var extraPonts: Int {
        switch self {
        case .ship1: return 0
        case .ship2: return 30
        case .ship3: return 50
        case .ship4: return 70
        case .ship5: return 100
        }
    }
    
    var image: ImageResource {
        switch self{
        case .ship1: .shipImage1
        case .ship2: .shipImage2
        case .ship3: .shipImage3
        case .ship4: .shipImage4
        case .ship5: .shipImage5
        }
    }
    
    var imageClose: ImageResource {
        switch self{
        case .ship1: .shipImage1
        case .ship2: .shipImage2Close
        case .ship3: .shipImage3Close
        case .ship4: .shipImage4Close
        case .ship5: .shipImage5Close
        }
    }
    
    var price: Int {
        switch self {
        case .ship1: return 0
        case .ship2: return 5000
        case .ship3: return 10000
        case .ship4: return 50000
        case .ship5: return 90000
        }
    }
    var id: Self { self }
    
}

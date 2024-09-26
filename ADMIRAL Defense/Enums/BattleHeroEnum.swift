//
//  BattleHeroEnum.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//
import SwiftUI

enum BattleHero: CaseIterable, Identifiable {
    var id: Self{
        self
    }
    
    case monster1
    case monster2
    case monster3
    case monster4
    case pirat1
    case pirat2
    case pirat3
    case admiral
    case jewerly1
    case jewerly2
    case jewerly3
    case bomb
    
    var heroNumber: Int {
        switch self{
            
        case .monster1:1
        case .monster2:2
        case .monster3:3
        case .monster4:4
        case .pirat1:5
        case .pirat2:6
        case .pirat3:7
        case .admiral:8
        case .jewerly1:9
        case .jewerly2:10
        case .jewerly3:11
        case .bomb:12
        }
    }
    
    var image: ImageResource {
        switch self{
            
        case .monster1: .monster1
        case .monster2: .monster2
        case .monster3: .monster3
        case .monster4: .monster4
        case .pirat1: .pirat1
        case .pirat2: .pirat2
        case .pirat3: .pirat3
        case .admiral: .admiral
        case .jewerly1: .jewerly1
        case .jewerly2: .jewerly2
        case .jewerly3: .jewerly3
        case .bomb: .bomb
        }
        
    }
}

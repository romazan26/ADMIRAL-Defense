//
//  BattleHeroCell.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct BattleHeroCell: View {
    var hero: BattleHero

    @State var height: CGFloat = 10
    
    var body: some View {
        VStack {
            Spacer()
           
                Image(hero.image)
                    .resizable()
                    .frame(height: scaleScreen_x(height))
            
            
        }
        .animation(.easeIn(duration: 0.5), value: height)
        .onAppear(perform: {
            height = 50
        })
        .frame(width: scaleScreen_x(58), height: scaleScreen_x(45))
    }
}

#Preview {
    BattleHeroCell(hero: BattleHero.admiral)
}

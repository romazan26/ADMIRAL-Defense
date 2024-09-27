//
//  battleFieldView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct battleFieldView: View {
    
    @StateObject var vm: BattleFieldViewmodel
    
    var body: some View {
                        
            ZStack {
                Image(.battleFieldBackground)
                    .resizable()
                LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: scaleScreen_x(70), maximum: scaleScreen_x(70))), count: vm.columns)) {
                    ForEach(0..<vm.totalCells, id: \.self) { index in
                        ZStack {
                            // Ячейки сетки
                            Image(.cellBaterfield)
                                .resizable()
                                .frame(width: scaleScreen_x(70), height: scaleScreen_x(60))
                            
                            // Отображение элемента в случайной ячейке
                            if let element = vm.elements.first(where: { $0.position == index }) {
                                BattleHeroCell(hero: element.hero)
                                    .onTapGesture {
                                        if (5...7) .contains(element.hero.heroNumber){
                                            vm.removeElement(at: element.position)
                                        }
                                        if element.hero == .bomb{
                                            vm.removeElementAndNeighbors(at: element.position)
                                        }
                                    }
                                    .onTapGesture(count: 2) {
                                        if (1...4) .contains(element.hero.heroNumber){
                                            vm.removeElement(at: element.position)
                                        }
                                    }
                                    .onLongPressGesture {
                                        if element.hero == .admiral{
                                            vm.removeElement(at: element.position)
                                        }
                                        if (9...11) .contains(element.hero.heroNumber){
                                            vm.addCoins(countCoins: 100)
                                            vm.removeElement(at: element.position)
                                        }
                                    }
                            }
                        }
                    }
                }
                
            }
            .frame(width: scaleScreen_x(358), height: scaleScreen_x(420))
            .onAppear {
                vm.startTimers(with: 30)
            }
        
        
        
    }
   
}

#Preview {
    battleFieldView(vm: BattleFieldViewmodel())
}
extension BattleHero{
    static func random() -> BattleHero{
        BattleHero.allCases.randomElement()!
    }
}


//
//  GameView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var vm: MainViewModel
    @StateObject var vmBattleField = BattleFieldViewmodel()

    var body: some View {
        ZStack {
            //MARK: - background
            Image(.gameBackground)
                .resizable()
                .ignoresSafeArea()
            battleFieldView(vm: vmBattleField)
                .padding(.bottom, scaleScreen_x(120))
            VStack{
                //MARK: - Top tool bar
                TopToolBarGame(actionPause: {vmBattleField.togglePause()}, timer: Int(vmBattleField.remainingTime), numberWave: Int(vm.simpleLevel.number), money: vmBattleField.moneyBattleField)
                Spacer()
                HStack(alignment: .bottom){
                    //MARK: - Ship info label
                    ShipInfoLabel()
                        .padding(.bottom)
                    Spacer()
                    //MARK: - Ship image
                    Image(.shipImage1)
                        .resizable()
                        .frame(width: scaleScreen_x(117), height: scaleScreen_x(170))
                }
                //MARK: - Health stroke
                HealthView(healthPercent: vmBattleField.healthBattleField)
            }.padding(.horizontal)
            
            //MARK: - Game over
            if vmBattleField.gameVictory {
                VictoryView(vm: vmBattleField, vmMain: vm)
            }
            
            if vmBattleField.gameOver {
                GameOverView(vm: vmBattleField, timerLeveltime: vm.simpleLevel.time)
            }
           
            if vmBattleField.isPauseview {
                PauseView(vm: vmBattleField, timerLeveltime: vm.simpleLevel.time)
            }
        }
    }
}

#Preview {
    GameView(vm: MainViewModel())
}

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
    @StateObject var vmShips: ShipsViewModel

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
                TopToolBarGame(actionPause: {vmBattleField.togglePause()}, timer: Int(vmBattleField.remainingTime), numberWave: Int(vm.simpleLevel.number), money: vmBattleField.simpleMoney)
                Spacer()
                HStack(alignment: .bottom){
                    //MARK: - Ship info label
                    ShipInfoLabel(health: vmShips.getFullHealth(),
                                  shield: vmShips.getFullShield(),
                                  extraPoints: vmShips.getFullExtraPoints())
                        .padding(.bottom)
                    Spacer()
                    //MARK: - Ship image
                    Image(vmShips.simpleShip.image)
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
        .onAppear {
            print("game appear")
            MusicManager.instance.playSound(sound: .gameMusic)
        }
        .onDisappear {
            MusicManager.instance.playSound(sound: .menuMusic)
        }
    }
}

#Preview {
    GameView(vm: MainViewModel(), vmShips: ShipsViewModel())
}

//
//  GameOverView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//

import SwiftUI

struct VictoryView: View {
    @StateObject var vm: BattleFieldViewmodel
    @StateObject var vmMain: MainViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.5)
            
            ZStack {
                Image(.settingsBackGround)
                    .resizable()
                VStack {
                    //MARK: - Label view
                    Text("DEFEAT")
                        .foregroundStyle(.settings)
                        .font(.system(size: scaleScreen_x(34), weight: .heavy, design: .monospaced))
                    //MARK: - Stars
                    HStack(spacing: -19){
                        Image(.fullStar)
                            .resizable()
                            .frame(width: scaleScreen_x(73), height: scaleScreen_x(73))
                            .offset(y: -20)
                        Image(vm.simpleCrore > 1 ? .fullStar : .nullStar)
                            .resizable()
                            .frame(width: scaleScreen_x(73), height: scaleScreen_x(73))
                        Image(vm.simpleCrore > 2 ? .fullStar : .nullStar)
                            .resizable()
                            .frame(width: scaleScreen_x(73), height: scaleScreen_x(73))
                            .offset(y: -20)
                    }.padding(.bottom, 10)
                    
                    //MARK: - Coins score
                    HStack {
                        Image(.coin)
                            .resizable()
                            .frame(width: scaleScreen_x(28), height: scaleScreen_x(28))
                        Spacer()
                        Text("\(vm.moneyBattleField)")
                            .foregroundStyle(.settings)
                            .font(.system(size: 24, weight: .heavy, design: .monospaced))
                    }.padding(.horizontal, scaleScreen_x(90))
                    
                    //MARK: - Next button
                    Button {
                        SoundManager.instance.playSound(sound: .buttonClick)
                        vmMain.nextLevel()
                        vm.restartGame(timertime: vmMain.simpleLevel.time)
                       
                    } label: {
                        SettingsButtonView(text: "NEXT")
                    }
                    
                    //MARK: - MENU button
                    Button {
                        dismiss()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        Text("Menu")
                            .foregroundStyle(.settings)
                            .font(.system(size: 32, weight: .heavy, design: .monospaced))
                    }


                }
            }
            .onAppear() {
                vmMain.completedLevel(score: Int16(vm.simpleCrore))
            }
            .frame(width: scaleScreen_x(332), height: scaleScreen_x(491))
        }
    }
}

#Preview {
    VictoryView(vm: BattleFieldViewmodel(), vmMain: MainViewModel())
}

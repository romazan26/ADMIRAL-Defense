//
//  GameOverView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//

import SwiftUI

struct PauseView: View {
    @StateObject var vm: BattleFieldViewmodel
    @Environment(\.dismiss) var dismiss
    let timerLeveltime: Double
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
                    Text("PAUSE")
                        .foregroundStyle(.settings)
                        .font(.system(size: scaleScreen_x(34), weight: .heavy, design: .monospaced))
                    
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
                    
                    //MARK: - Restart button
                    Button {
                        vm.restartGame(timertime: timerLeveltime)
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        SettingsButtonView(text: "RESTART")
                    }
                    //MARK: - Restart button
                    Button {
                        dismiss()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        SettingsButtonView(text: "MENU")
                    }
                    
                    //MARK: - MENU button
                    Button {
                        vm.togglePause()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        Text("Back")
                            .foregroundStyle(.settings)
                            .font(.system(size: 32, weight: .heavy, design: .monospaced))
                    }


                }
            }.frame(width: scaleScreen_x(332), height: scaleScreen_x(491))
        }
    }
}

#Preview {
    PauseView(vm: BattleFieldViewmodel(), timerLeveltime: 30)
}

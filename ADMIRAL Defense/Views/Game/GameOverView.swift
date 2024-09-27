//
//  GameOverView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 27.09.2024.
//

import SwiftUI

struct GameOverView: View {
    @StateObject var vm: BattleFieldViewmodel
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
                        Image(.nullStar)
                            .resizable()
                            .frame(width: scaleScreen_x(73), height: scaleScreen_x(73))
                            .offset(y: -20)
                        Image(.nullStar)
                            .resizable()
                            .frame(width: scaleScreen_x(73), height: scaleScreen_x(73))
                        Image(.nullStar)
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
                    
                    //MARK: - Restart button
                    Button {
                        
                    } label: {
                        SettingsButtonView(text: "RESTART")
                    }
                    
                    //MARK: - MENU button
                    Button {
                        
                    } label: {
                        Text("Menu")
                            .foregroundStyle(.settings)
                            .font(.system(size: 32, weight: .heavy, design: .monospaced))
                    }


                }
            }.frame(width: scaleScreen_x(332), height: scaleScreen_x(491))
        }
    }
}

#Preview {
    GameOverView(vm: BattleFieldViewmodel())
}

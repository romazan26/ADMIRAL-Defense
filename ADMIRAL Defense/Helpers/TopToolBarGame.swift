//
//  TopToolBarGame.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct TopToolBarGame: View {
    var actionPause: () -> Void
    var timer = 15
    var numberWave = 1
    var money = 567
    var body: some View {
        HStack{
            //MARK: - Pause button
            Button {
                actionPause()
            } label: {
                Image(.pause)
                    .resizable()
                    .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
            }
            Spacer()
            //MARK: Wave and timer
            VStack{
                Text("\(numberWave) WAVE")
                    .font(.system(size: 32, weight: .heavy, design: .monospaced))
                Text("00:\(timer)")
                    .font(.system(size: 24, weight: .heavy, design: .monospaced))
            }
            .foregroundStyle(.settings)
            .background {
                Color(.white)
                    .blur(radius: 10)
            }
            Spacer()
            
            //MARK: - Money
            VStack(alignment: .trailing){
                Image(.coin)
                    .resizable()
                    .frame(width: scaleScreen_x(28), height: scaleScreen_x(28))
                Text("\(money)")
                    .font(.system(size: 24, weight: .heavy, design: .monospaced))
                    .foregroundStyle(.settings)
                    .background {
                        Color(.white)
                            .blur(radius: 10)
                    }
            }

        }
    }
}

#Preview {
    TopToolBarGame(actionPause: {})
}

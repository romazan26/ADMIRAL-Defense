//
//  TopToolBarGame.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//

import SwiftUI

struct TopToolbarShips: View {
    @Environment(\.dismiss) var dismiss
    var money: Int
    var body: some View {
        HStack{
            //MARK: - Back button
            Button {
                dismiss()
            } label: {
                Image(.backButton)
                    .resizable()
                    .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
            }
            Spacer()
            //MARK: Label view
           
                Text("SHIPS")
                    .font(.system(size: 32, weight: .heavy, design: .monospaced))
        
            
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
    TopToolbarShips( money: 50)
}

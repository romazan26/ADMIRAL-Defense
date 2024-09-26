//
//  ShipInfoLabel.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct ShipInfoLabel: View {
    var body: some View {
        ZStack {
            Image(.shipInfoBackground)
                .resizable()
            HStack {
                VStack(alignment: .leading) {
                    Text("HEALTH:")
                    Text("SHIELD:")
                    Text("EXTRA POINTS:")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("+10%")
                    Text("OFF")
                    Text("+10%")
                }
            }
            .padding()
            .foregroundStyle(.white)
                .font(.system(size: scaleScreen_x(16), weight: .heavy, design: .monospaced))
        }.frame(width: scaleScreen_x(191), height: scaleScreen_x(73))
    }
}

#Preview {
    ShipInfoLabel()
}

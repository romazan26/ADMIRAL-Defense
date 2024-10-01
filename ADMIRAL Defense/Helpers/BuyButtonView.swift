//
//  BuyButtonView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 01.10.2024.
//

import SwiftUI

struct BuyButtonView: View {
    var text: String
    var body: some View {
        ZStack {
            Image(.settingbuttonBackground)
                .resizable()
            HStack {
                Image(.coin)
                    .resizable()
                    .frame(width: scaleScreen_x(20), height: scaleScreen_x(20))
                Text(text)
                    .foregroundStyle(.settings)
                    .font(.system(size: scaleScreen_x(20), weight: .heavy, design: .monospaced))
            }
        }.frame(width: scaleScreen_x(130), height: scaleScreen_x(30))
    }
}

#Preview {
    BuyButtonView(text: "10000")
}

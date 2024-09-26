//
//  SettingsButtonView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct SettingsButtonView: View {
    var text: String
    var body: some View {
        ZStack {
            Image(.settingbuttonBackground)
                .resizable()
            Text(text)
                .foregroundStyle(.settings)
                .font(.system(size: scaleScreen_x(32), weight: .heavy, design: .monospaced))
        }.frame(width: scaleScreen_x(184), height: scaleScreen_x(60))
    }
}

#Preview {
    SettingsButtonView(text: "POLICY")
}

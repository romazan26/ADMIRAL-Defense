//
//  HealthView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI

struct HealthView: View {
    var healthPercent: Int

    var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                Image(.healthBack)
                    .resizable()
                Image(.healthFront)
                    .resizable()
                    .frame(width: ((scaleScreen_x(339 / 100)) * CGFloat(healthPercent)), height: scaleScreen_x(33))
                    .padding(.bottom, scaleScreen_x(10))
                    .padding(.leading, scaleScreen_x(10))
            }
            Text("\(healthPercent)")
                .foregroundStyle(.white)
                .font(.system(size: scaleScreen_x(32), weight: .bold))
                .padding(.bottom, scaleScreen_x(9))
        }
        .animation(.bouncy, value: healthPercent)
        .frame(width: scaleScreen_x(358), height: scaleScreen_x(58))
    }
}

#Preview {
    HealthView(healthPercent: 100)
}

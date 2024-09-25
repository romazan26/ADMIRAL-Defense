//
//  LevelsProgressView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI

struct LevelsProgressView: View {
    @StateObject var vm: MainViewModel
    var body: some View {
        
                ScrollView {
                    ZStack(alignment: .bottom) {
                        Image(.mapLevelBackGround)
                            .resizable()
                            .scaledToFit()
                        VStack(spacing: scaleScreen_y(100)) {
                            ForEach(vm.levels.reversed()) { level in
                                LevelCellView(level: level)
                            }
                        }.padding(.bottom, 70)
                    }
                        
                }.ignoresSafeArea()
            }
        
    
}

#Preview {
    LevelsProgressView(vm: MainViewModel())
}

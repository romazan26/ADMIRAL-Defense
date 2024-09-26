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
                                Button {
                                    vm.simpleLevel = level
                                } label: {
                                    LevelCellView(level: level, choose: vm.simpleLevel == level ? true : false)
                                }
                                .disabled(level.isOpen ? false : true)

                                
                            }
                        }.padding(.bottom, scaleScreen_x(100))
                    }
                        
                }.ignoresSafeArea()
            }
        
    
}

#Preview {
    LevelsProgressView(vm: MainViewModel())
}

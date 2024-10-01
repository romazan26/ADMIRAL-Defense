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
        
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                ZStack(alignment: .bottom) {
                    Image(.mapLevelBackGround)
                        .resizable()
                        .scaledToFit()
                    VStack(spacing: scaleScreen_y(100)) {
                        ForEach(vm.levels.reversed()) { level in
                            Button {
                                vm.simpleLevel = level
                                print("tap")
                                print("level: \(vm.simpleLevel)")
                            } label: {
                                LevelCellView(level: level, choose: vm.simpleLevel == level ? true : false)
                            }
                            .disabled(level.isOpen ? false : true)
                            
                            
                        }
                    }.padding(.bottom, scaleScreen_x(100))
                }
                
            }
            .onAppear(perform: {
                scrollToBottom(proxy: scrollViewProxy)
            })
            .ignoresSafeArea()
        }
            }
    // Функция для прокрутки к последнему элементу
        private func scrollToBottom(proxy: ScrollViewProxy) {
            
            if let lastLevel = vm.levels.first {
                DispatchQueue.main.async {
                    withAnimation {
                        proxy.scrollTo(lastLevel, anchor: .bottom)
                    }
                }
            }
        }
    
}

#Preview {
    LevelsProgressView(vm: MainViewModel())
}

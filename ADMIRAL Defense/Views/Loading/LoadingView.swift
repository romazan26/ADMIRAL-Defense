//
//  ContentView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI

struct LoadingView: View {
    @State private var percents: Int = 0
    @AppStorage("isFirstStart") var isFirstStart: Bool?
    @State private var isPresent = false
    var body: some View {
        ZStack{
            Image(.backGroundLoading)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: scaleScreen_x(330), height: scaleScreen_x(330))
                Text("\(percents)%")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .heavy, design: .monospaced))
                    .background {
                        Capsule()
                            .foregroundStyle(.white)
                            .blur(radius: 25)
                    }
            }
        }
        .fullScreenCover(isPresented: $isPresent, content: {
            if isFirstStart ?? true{
                IntroView() 
            }else{
                MainMenuView()
            }
        })
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { timer in
                if percents < 100{
                    percents += 1
                }else {
                    timer.invalidate()
                    isPresent = true
                }
            }
        })
    }
}

#Preview {
    LoadingView()
}

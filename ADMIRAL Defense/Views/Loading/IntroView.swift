//
//  IntroView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("isFirstStart") var isFirstStart: Bool?
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //MARK: - Intro image
            Image(.intro)
                .resizable()
                .ignoresSafeArea()
            
            //MARK: - Skip button
            Button {
                isFirstStart = false
                isPresented = true
            } label: {
                Text("SKIP")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .heavy))
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            MainMenuView()
        }
    }
}

#Preview {
    IntroView()
}

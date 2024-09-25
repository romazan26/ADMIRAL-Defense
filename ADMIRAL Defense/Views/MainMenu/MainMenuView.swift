//
//  MainMenuView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI

struct MainMenuView: View {
    
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        ZStack {
            LevelsProgressView(vm: vm)
        }
    }
}

#Preview {
    MainMenuView()
}

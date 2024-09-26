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
            VStack{
                Spacer()
                
                //MARK: - Bottom bar
                HStack{
                    //MARK: Settings button
                    Button {
                        vm.isPresentSettings.toggle()
                    } label: {
                        Image(.settings)
                            .resizable()
                            .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                    }

                    
                    Image(.startbutton)
                        .resizable()
                        .frame(width: scaleScreen_x(184), height: scaleScreen_x(60))
                    Image(.ship)
                        .resizable()
                        .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                }
            }
            if vm.isPresentSettings{
                SettingsView(isPresentSettings: $vm.isPresentSettings)
            }
        }
    }
}

#Preview {
    MainMenuView()
}

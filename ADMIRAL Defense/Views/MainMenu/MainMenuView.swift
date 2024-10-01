//
//  MainMenuView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI

struct MainMenuView: View {
    
    @StateObject var vm = MainViewModel()
    @StateObject var vmShips = ShipsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LevelsProgressView(vm: vm)
                VStack{
                    //MARK: - Sounds button
                    HStack{
                        Spacer()
                        VStack{
                            Button {
                                SoundManager.instance.playSound(sound: .buttonClick)
                                vm.soundMute()
                            } label: {
                                Image(vm.volumeSound == "0" ? .soundOff : .soundMute)
                                    .resizable()
                                    .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                            }
                            Button {
                                SoundManager.instance.playSound(sound: .buttonClick)
                                vm.musicMute()
                            } label: {
                                Image(vm.volumeMusic == "0" ? .musicOff : .musicMute)
                                    .resizable()
                                    .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                            }

                        }.padding(.horizontal)
                    }
                    Spacer()
                    
                    //MARK: - Bottom bar
                    HStack{
                        //MARK: Settings button
                        Button {
                            vm.isPresentSettings.toggle()
                            SoundManager.instance.playSound(sound: .buttonClick)
                        } label: {
                            Image(.settings)
                                .resizable()
                                .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                        }
                        
                        //MARK: - Start button
                        NavigationLink {
                            GameView(vm: vm, vmShips: vmShips)
                                .onAppear {
                                    SoundManager.instance.playSound(sound: .buttonClick)
                                }
                        } label: {
                            Image(.startbutton)
                                .resizable()
                                .frame(width: scaleScreen_x(184), height: scaleScreen_x(60))
                        }
                        .disabled(vm.simpleLevel == nil ? true : false)

                        //MARK: - Ships button
                        NavigationLink {
                            ShipsView(vm: vmShips)
                                .onAppear {
                                    SoundManager.instance.playSound(sound: .buttonClick)
                                }
                        } label: {
                            Image(.ship)
                                .resizable()
                                .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                        }  
                    }
                }
                if vm.isPresentSettings{
                    SettingsView(isPresentSettings: $vm.isPresentSettings)
                }
            }
        }
        .onAppear {
            MusicManager.instance.playSound(sound: .menuMusic)
        }
    }
}

#Preview {
    MainMenuView()
}

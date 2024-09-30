//
//  ShipsView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//

import SwiftUI

struct ShipsView: View {
    @StateObject var vm: ShipsViewModel
    var body: some View {
        ZStack {
            //MARK: - BackGround
            Image(.shipsBackground)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                TopToolbarShips(money: vm.simpleMoney)
                HStack{
                    Spacer()
                    ShipInfolLabelView(vm: vm)
                }.padding(.top)
                //MARK: - Ship image
                if vm.getIsOpen() {
                    Image(vm.simpleShip.image)
                        .resizable()
                        .frame(width: scaleScreen_x(220), height: scaleScreen_x(320))
                }else{
                    VStack {
                        ZStack {
                            Image(vm.simpleShip.imageClose)
                                .resizable()
                                .frame(width: scaleScreen_x(180), height: scaleScreen_x(260))
                            Text("\(vm.simpleShip.price)")
                                .foregroundStyle(.red)
                                .font(.system(size: 72,weight: .heavy,design: .monospaced))
                                .rotationEffect(.degrees(-52))
                        }
                        Spacer()
                        
                        //MARK: Buy button
                        Button {
                            vm.buyShip()
                        } label: {
                            SettingsButtonView(text: "BUY")
                        }

                    }
                }
                
                Spacer()
                
                //MARK: - Choose ship buttons
                HStack{
                    if vm.simpleShip.number > 1{
                        Button {
                            vm.getSimpleShip(number: vm.simpleShip.number - 1)
                        } label: {
                            Image(.backButton)
                                .resizable()
                                .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                        }
                    }
                    if vm.simpleShip.number < 5{
                        Button {
                            vm.getSimpleShip(number: vm.simpleShip.number + 1)
                        } label: {
                            Image(.nextButton)
                                .resizable()
                                .frame(width: scaleScreen_x(60), height: scaleScreen_x(60))
                        }
                    }

                }
            }.padding()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ShipsView(vm: ShipsViewModel())
}

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
                    //MARK: CHEATS
                        .onTapGesture {
                            vm.simpleMoney = 1000000
                        }
                }.padding(.top)
                Spacer()
                //MARK: - Ship image
                if vm.getIsOpen() {
                    VStack {
                        Image(vm.simpleShip.image)
                            .resizable()
                            .frame(width: scaleScreen_x(180), height: scaleScreen_x(230))
                        UpgradeShipView(vm: vm)
                    }
                    
                }else{
                    VStack {
                        ZStack {
                            Image(vm.simpleShip.imageClose)
                                .resizable()
                                .frame(width: scaleScreen_x(180), height: scaleScreen_x(230))
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
                            BuyButtonView(text: "BUY")
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
                                .frame(width: scaleScreen_x(50), height: scaleScreen_x(50))
                        }
                    }
                    if vm.simpleShip.number < 5{
                        Button {
                            vm.getSimpleShip(number: vm.simpleShip.number + 1)
                        } label: {
                            Image(.nextButton)
                                .resizable()
                                .frame(width: scaleScreen_x(50), height: scaleScreen_x(50))
                        }
                    }

                }
            }.padding()
                .navigationBarBackButtonHidden()
        }
        .onAppear(){
            vm.loadMoney()
            print("load money")
        }
    }
}

#Preview {
    ShipsView(vm: ShipsViewModel())
}

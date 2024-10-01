//
//  UpgradeShipView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 01.10.2024.
//

import SwiftUI

struct UpgradeShipView: View {
    @StateObject var vm: ShipsViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("HEALTH +10%")
                        Spacer()
                        Button {
                            vm.buyHealthUpgrade()
                        } label: {
                            BuyButtonView(text: "10000")
                        }
                    }
                    HStack {
                        Text("SHIELD +10%")
                        Spacer()
                        Button {
                            vm.buyShieldUpgrade()
                        } label: {
                            BuyButtonView(text: "10000")
                        }
                    }
                    
                    HStack {
                        Text("POIUNTS +10%")
                        Spacer()
                        Button {
                            vm.buyPointsUpgrade()
                        } label: {
                            BuyButtonView(text: "10000")
                        }
                    }
                    
                }.font(.system(size: scaleScreen_x(18), weight: .heavy, design: .monospaced))
            }.padding(8)
        }
        .frame(width: scaleScreen_x(358), height: scaleScreen_x(120))
        .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        Color.black
        UpgradeShipView(vm: ShipsViewModel())
    }
        
}

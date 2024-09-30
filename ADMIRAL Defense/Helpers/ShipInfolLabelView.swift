//
//  ShipInfolLabelView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 30.09.2024.
//
import SwiftUI

struct ShipInfolLabelView: View {
    @StateObject var vm : ShipsViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:  8)
                .stroke(lineWidth: 2)
            HStack{
                VStack(alignment: .leading){
                    Text("HEALTH:")
                    Text("SHIELD:")
                    Text("EXTRA POINTS:")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("+\(vm.getFullHealth())%")
                    Text("+\(vm.getFullShield())%")
                    Text("+\(vm.getFullExtraPoints())%")
                }
            }
            .padding()
            .font(.system(size: scaleScreen_x(16), weight: .heavy, design: .monospaced))
            
        }
        .foregroundStyle(.white)
        .frame(width: scaleScreen_x(237), height: scaleScreen_x(73))
    }
    
    
}
#Preview {
    ZStack {
        Color.black
        ShipInfolLabelView(vm: ShipsViewModel())
    }
}

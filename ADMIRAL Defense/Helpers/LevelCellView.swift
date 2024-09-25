//
//  LevelCellView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 25.09.2024.
//

import SwiftUI

struct LevelCellView: View {
    
    @ObservedObject var level: GameLevel
    let offset: CGFloat
    
    init(level: GameLevel) {
        self.level = level
        let offsets: [CGFloat] = [0, 75, 0, 40, -50, 50, 25, 0]
        offset =  offsets[Int(level.number - 1) % 8]
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
        ZStack {
            Image(.levelBackGround)
                .resizable()
            Text("\(level.number)")
                .foregroundStyle(.red)
                .font(.system(size: scaleScreen_x(32), weight: .heavy, design: .monospaced))
                .padding(.bottom)
        }
            if level.isOpen{
                HStack(spacing: -8){
                    Image(level.score > 0 ? .fullStar : .nullStar)
                        .resizable()
                        .frame(width: scaleScreen_x(32), height: scaleScreen_x(32))
                        .offset(y: -10)
                    Image(level.score > 1 ? .fullStar : .nullStar)
                        .resizable()
                        .frame(width: scaleScreen_x(32), height: scaleScreen_x(32))
                    Image(level.score > 2 ? .fullStar : .nullStar)
                        .resizable()
                        .frame(width: scaleScreen_x(32), height: scaleScreen_x(32))
                        .offset(y: -10)
                }.padding(.bottom, 10)
            }else{
                Image(.closed)
                    .resizable()
                
            }
        }
        .frame(width: scaleScreen_x(80), height: scaleScreen_x(100))
        .offset(x: scaleScreen_x(offset))
    }
}

#Preview {
    LevelsProgressView(vm: MainViewModel())
}

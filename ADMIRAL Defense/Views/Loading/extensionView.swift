//
//  extensionView.swift
//  Mrbet
//
//  Created by Роман on 16.09.2024.
//

import SwiftUI

extension View{
    func scaleScreen_y(_ value : CGFloat) -> CGFloat{
        let y = UIScreen.main.bounds.height/812
        return value * y
    }
    
    func scaleScreen_x(_ value : CGFloat) -> CGFloat{
        let x = UIScreen.main.bounds.width/375
        return value * x
    }
}

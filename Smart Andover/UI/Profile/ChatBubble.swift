//
//  ChatBubble.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/19/21.
//

import SwiftUI

struct ChatBubble: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let minX = rect.minX
        let minY = rect.minY
        let maxX = rect.maxX
        let maxY = rect.maxY
        
        let width = maxX - minX
        let height = maxY - minY
        
        path.addRoundedRect(in: .init(x: 0, y: 0, width: width, height: height), cornerSize: .init(width: 10, height: 10))
        path.addLine(to: .init(x: minX+50, y: maxY))
        path.addLine(to: .init(x: minX+40, y: maxY+7))
        path.addCurve(to:       .init(x: minX+30, y: maxY+7),
                      control1: .init(x: minX+40, y: maxY+7),
                      control2: .init(x: minX+30, y: maxY+15))
        path.addLine(to: .init(x: minX+30, y: maxY))
        
        return path
        
    }
    
}

//
//  Bubble.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/14/21.
//

import SwiftUI


private struct BubbleStyle: ViewModifier {
    
    let color: Color
    let padAmount: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(padAmount)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill().foregroundColor(color)
                    .shadow(color: .secondary, radius: 2)
            )
        
    }
    
}

extension View {
    
    func bubbleStyle (color: Color = .init(.systemBackground), padding length: CGFloat = 10) -> some View {
        self.modifier(BubbleStyle(color: color, padAmount: length))
    }
    
}

//
//  BarButtonStyle.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/14/21.
//

import SwiftUI

struct BarButtonStyle: ButtonStyle {
    
    var tint: Color = .theme
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(tint.opacity(configuration.isPressed ? 0.8 : 1))
            .cornerRadius(20)
        
    }
    
}

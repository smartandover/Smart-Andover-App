//
//  RequiredField.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/26/21.
//

import SwiftUI

private struct RequiredField: ViewModifier {
    
    @Binding var showLabel: Bool
    
    func body(content: Content) -> some View {
        
        HStack {
            
            if showLabel {
                
                Image(systemName: "staroflife.fill")
                    .foregroundColor(.red)
                    .aspectRatio(1, contentMode: .fit)
                    .font(.system(.caption2, design: .rounded))
                
            }
            
            content
            
        }
        
    }
    
}

extension View {
    
    func requiredField (_ show: Binding<Bool>) -> some View {
        self.modifier(RequiredField(showLabel: show))
    }
    
}


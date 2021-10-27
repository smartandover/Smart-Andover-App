//
//  ProgressViewStyle.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/14/21.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    
    var tint: Color = .theme
    
    func makeBody(configuration: Configuration) -> some View {
        
        ProgressView(configuration)
            .progressViewStyle(LinearProgressViewStyle(tint: tint))
        
    }
    
}

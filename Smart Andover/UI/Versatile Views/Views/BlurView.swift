//
//  BlurView.swift
//  Chess AI
//
//  Created by Chaniel Ezzi on 8/7/21.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    
    typealias NSViewType = UIVisualEffectView
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
        
    }
    
    func updateUIView(_ nsView: UIVisualEffectView, context: Context) {
        
    }
    
}

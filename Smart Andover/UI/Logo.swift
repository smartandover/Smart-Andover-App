//
//  Logo.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/16/21.
//

import SwiftUI

///Smart Andover's logo. Use '.scaleEffect()' to change the size of the logo.
struct SmartAndoverLogo: View {
    
    var body: some View {
        
        HStack {
            
//            Image("SmartAndoverSquare").resizable()
//                .aspectRatio(contentMode: .fit)
            
            (Text("Smart") + Text("Andover").foregroundColor(.theme).bold())
                .fixedSize()
                .lineLimit(1)
            
        }
        
    }
    
}

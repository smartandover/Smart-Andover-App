//
//  RewardsList.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/2/21.
//

import SwiftUI

struct RewardsView: View {
    
    var body: some View {
        
        let layout = [GridItem(.flexible()),
                      GridItem(.flexible())]
        
        LazyVGrid(columns: layout) {
            
            ForEach (0..<3) { _ in
                
                VStack {
                    
                    Image("cookie").resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Den Cookie")
                        .foregroundColor(.themeDark).bold()
                        .font(.callout)
                    
                    Text("100 points")
                        .foregroundColor(.primary)
                        .font(.system(size: 15))
                    
                }
                .aspectRatio(1, contentMode: .fit)
                .bubbleStyle()
                .padding(5)
                
            }
            
        }
        
    }
    
}

//
//  RewardPreview.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 2/10/22.
//

import SwiftUI

struct RewardPreview: View {
    
    let reward: Reward
    @Binding var selectedReward: Reward?
    
    var body: some View {
        
        Button(action: {
            
            selectedReward = reward
            
        }, label: {
            
            VStack {
                reward.image.resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(reward.name)
                    .foregroundColor(.themeDark).bold()
                    .font(.callout)
                
                Text("\(reward.pointsCost) points")
                    .foregroundColor(.primary)
                    .font(.system(size: 15))
                
            }
            .aspectRatio(0.75, contentMode: .fit)
            .bubbleStyle()
            .padding(.vertical, 5)
            
        })
        
    }
    
}

//
//  RewardsList.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/2/21.
//

import SwiftUI

struct RewardsView: View {
    
    @Environment(\.currentUser) var user
    @State var rewards: [Reward]?
    
    var body: some View {
        
        if rewards == nil {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    DatabaseController.getRewardData { rewards in
                        self.rewards = rewards
                    }
                }
        }
        else if rewards!.isEmpty {
            Text("No Rewards Are Being Offered Right Now")
                .font(.caption)
                .foregroundColor(.themeDark)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        else {
            
            let layout = [GridItem(.flexible()),
                          GridItem(.flexible())]
            LazyVGrid(columns: layout) {
                
                ForEach (rewards!, id: \.self) { reward in
                    
                    Button(action: {
                        DatabaseController.redeemPoints(user: user.wrappedValue!, reward: reward) { error in
                            print(error)
                        }
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
                        .aspectRatio(1, contentMode: .fit)
                        .bubbleStyle()
                        .padding(.vertical, 5)
                    })
                    
                }
                
            }
            
        }
        
    }
    
}

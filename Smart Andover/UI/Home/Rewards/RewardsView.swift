//
//  RewardsList.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/2/21.
//

import SwiftUI

struct RewardsView: View {
    
    @Environment(\.currentUser) private var user
    
    @State var rewards: [Reward]?
    @State private var selectedReward: Reward?
    
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
            
            Text("No Rewards Are Being Offered Right Now. Hold On To Your Points!")
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
                    
                    RewardPreview(reward: reward, selectedReward: $selectedReward)
                        .sheet(item: $selectedReward) { selected in
                            
                            ZStack {
                                Color.white
                                    .ignoresSafeArea()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                RewardDetailView(user: _user, reward: selected)
                                    .padding().padding()
                            }
                            
                        }
                    
                }
                
            }
            
        }
        
    }
    
}

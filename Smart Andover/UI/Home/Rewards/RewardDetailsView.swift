//
//  RewardDetailsView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 2/10/22.
//

import SwiftUI

struct RewardDetailView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.currentUser) var user
    
    let reward: Reward
    
    @State var error: Error?
    
    var body: some View {
        
        VStack {
            
            reward.image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 300, alignment: .center)
                .padding()
            
            Text(reward.name)
                .foregroundColor(.themeDark).bold()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Redeem \(reward.pointsCost) Points") {
                
                DatabaseController.buyCoupon(user: user.wrappedValue!, reward: reward) { er in
                    
                    if er != nil {
                        error = er
                    }
                    else {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
                
            }
            .bubbleStyle(color: .blue)
            .cornerRadius(50)
            .foregroundColor(.white)
            
            Text("Your points: \(user.wrappedValue!.points)")
                .foregroundColor(.themeDark)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if let error = error {
                Text("Oops! " + error.localizedDescription)
                    .foregroundColor(.red)
                    .font(.caption)
                    .layoutPriority(1)
            }
            
        }
        
    }
    
}

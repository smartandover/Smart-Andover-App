//
//  LeaderboardItem.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/25/21.
//

import SwiftUI

struct LeaderboardItem: View {
    
    let user: User
    
    var body: some View {
        
        HStack {
            
            Image(systemName: "person.circle.fill")
                .font(.system(.title, design: .rounded))
                .foregroundColor(.theme)
                .clipShape(Circle())
            
            Text(user.firstName + " " + user.lastName)
                .font(.system(.title3, design: .rounded))
                .lineLimit(1)
                .foregroundColor(.primary)
                .fixedSize()
            
        }
        
    }
    
}

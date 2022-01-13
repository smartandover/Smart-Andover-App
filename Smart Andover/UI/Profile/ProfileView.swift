//
//  ProfileView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/15/21.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.currentUser) var user
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                VStack {
                    Image(systemName: "person.circle.fill").resizable()
                        .scaledToFit()
                        .foregroundColor(.themeDark)
                        .frame(maxWidth: 100, alignment: .leading)
                    
                    Text("\(user.wrappedValue!.firstName) \(user.wrappedValue!.lastName)")
                        .foregroundColor(.themeDark)
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                
                Divider()
            
                Label("My Submissions", systemImage: "photo.on.rectangle.angled")
                    .foregroundColor(.themeDark)
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                ProfileSubmissionsView()
                
                
                Label("My Coupons", systemImage: "giftcard")
                    .foregroundColor(.themeDark)
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                ProfileOrdersView()
                
                Spacer(minLength: 100)
            
            }
            
        }
        
    }
    
}

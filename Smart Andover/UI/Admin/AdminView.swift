//
//  AdminView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 3/24/22.
//

import SwiftUI

struct AdminView: View {
    
    @Environment(\.currentUser) private var user
    
    var body: some View {
        
        NavigationView {
            
            VStack (spacing: 20) {
            
                VStack {
                    Image(systemName: "checkmark.seal.fill").resizable()
                        .scaledToFit()
                        .foregroundColor(.themeDark)
                        .frame(maxWidth: 100, alignment: .leading)
                    
                    Text("\(user.wrappedValue!.authority.title)")
                        .foregroundColor(.themeDark)
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                .navigationBarTitleDisplayMode(.inline)
                
                NavigationLink {
                    AdminScannerView()
                        .navigationTitle("Scan Coupons")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Label("Scan Coupons", systemImage: "qrcode.viewfinder")
                        .foregroundColor(.themeDark)
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                NavigationLink {
                    AdminRewardAddition()
                        .navigationTitle("Add Reward")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Label("Add Reward", systemImage: "gift.circle")
                        .foregroundColor(.themeDark)
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                NavigationLink {
                    AdminSubmissionsView()
                        .navigationTitle("User Submissions")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Label("User Submissions", systemImage: "text.below.photo")
                        .foregroundColor(.themeDark)
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                Spacer()
                
            }
            
        }
        
    }
    
}

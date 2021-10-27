//
//  LeaderboardView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/25/21.
//

import SwiftUI

struct LeaderboardView: View {
    
    @State var topTenUsers: [User] = []
    
    var body: some View {
        
        VStack {
            
            Color.clear.frame(height: 0)
                .onAppear {
                    DatabaseController.database
                        .collection("Users")
                        .order(by: "points", descending: true)
                        .limit(to: 10)
                        .getDocuments { query, error in
                            
                            guard let query = query else { return }
                            
                            topTenUsers = query.documents.map { document -> User in
                                
                                let data = document.data()
                                
                                let email = data["email"] as? String ?? "Broken"
                                let fn = data["firstName"] as? String ?? "Broken"
                                let ln = data["lastName"] as? String ?? "Broken"
                                let auth = data["authority"] as? Int ?? 0
                                let points = data["points"] as? Int ?? -1
                                
                                return User(email: email, firstName: fn, lastName: ln, authority: Authority(rawValue: auth)!, points: points)
                                
                            }
                            
                        }
                    
                }
            
            List(topTenUsers.enumerated().map({$0}), id: \.element.email) { index, user in
                
                HStack {
                    if index == 0 {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.yellow)
                    }
                    else {
                        Text("\(index + 1).").bold()
                            .foregroundColor(.themeDark)
                    }
                    LeaderboardItem(user: user)
                }
                .padding()
                
            }
            .listItemTint(.themeLight)
            .foregroundColor(.themeDark)
            .listRowBackground(Color.themeLight)
            
        }
        
    }
    
}

//
//  MasterView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/12/21.
//

import SwiftUI

// Here for readability. Can use strings or integers for tags.
private enum TabState: Hashable {
    case profile, home, rewards, leaderboard, authorized
}

struct MasterView: View {
    
    @Environment(\.currentUser) var user
    // The page open when the app is first launched
    @State private var selectedTab: TabState = .rewards
    
    var body: some View {
        
        TabView(selection: $selectedTab) {

            // Profile
            TabLink(tabItem: Image(systemName: "person").padding(), destination: ProfileView())
                .tag(TabState.profile)
            
            //Leaderboard
            TabLink(tabItem: Image(systemName: "person.3").padding(), destination: LeaderboardView())
                .tag(TabState.leaderboard)

            // Home
            TabLink(tabItem: Image(systemName: "house").padding(), destination:
                    VStack {
                        PhotoCaptureView()
                    }
            )
                .tag(TabState.home)
            
            if user.wrappedValue!.authority.isAuthorized {
                
                //Auth view
                TabLink(tabItem: Image(systemName: "checkmark.circle").padding(), destination: AdminView())
                    .tag(TabState.authorized)
                
            }

//            // Settings
            TabLink(tabItem: Image(systemName: "gift").padding(), destination: HomeView())
            .tag(TabState.rewards)
            
            //Rewards

        }
        
    }
    
}

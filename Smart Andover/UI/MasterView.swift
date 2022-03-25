//
//  MasterView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/12/21.
//

import SwiftUI

struct MasterView: View {
    
    @Environment(\.currentUser) private var user
    
    // The page open when the app is first launched
    @Binding var selectedTab: NavigationPages
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            ForEach(NavigationPages.allCases, id: \.self) { page in
                
                if (page != .authorized) || (user.wrappedValue?.authority.isAuthorized ?? false) {
                    
                    TabLink(tabItem: Image(systemName: page.systemImageName).padding(), destination: page.view)
                        .tag(page)
                    
                }
                
            }
            
            

        }
        
    }
    
}

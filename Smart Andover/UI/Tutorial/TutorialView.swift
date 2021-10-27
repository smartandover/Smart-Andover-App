//
//  TutorialView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/13/21.
//

import SwiftUI

struct TutorialView: View {
    
    var body: some View {
        
        TabView {
            
            TabLink(tabItem: Image(systemName: "")) { 
                EmptyView()
            }

            
        }
        .tabViewStyle(PageTabViewStyle())
        
    }
    
}


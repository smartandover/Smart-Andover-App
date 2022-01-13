//
//  NavigationPages.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/5/21.
//

import SwiftUI

enum NavigationPages {
    
    // Profile useless atm, if we are going to use school accounts
    case home, leaderboard, authorized, profile, settings
    
    static var allCases: [NavigationPages] = [.home, .leaderboard, .authorized]
    
    var title: String {
        switch self {
        case .home:        return "Home"
        case .leaderboard: return "Leaderboard"
        case .profile:     return "Profile"
        case .authorized:  return "Submissions"
        case .settings:    return "Settings"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .home:        return "house.fill"
        case .leaderboard: return "person.3.fill"
        case .profile:     return "person.fill"
        case .authorized:  return "checkmark.seal.fill"
        case .settings:    return "gearshape.fill"
        }
    }
    
    @ViewBuilder func label() -> some View {
        switch self {
        
        case .home:
            SmartAndoverLogo()
            
        default:
            Text(self.title).bold()
                .fixedSize()
                .lineLimit(1)
        
        }
    }
    
}

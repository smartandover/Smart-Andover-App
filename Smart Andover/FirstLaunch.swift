//
//  FirstLaunch.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/16/21.
//

import Foundation

extension UserDefaults {
    
    static func IsFirstLaunch () -> Bool {
        
        let hasLaunchedFlag = "AppHasLaunched#Flag"
        let hasLaunched = UserDefaults.standard.bool(forKey: hasLaunchedFlag)
        
        if hasLaunched {
            return false
        }
        else {
            
            UserDefaults.standard.set(true, forKey: hasLaunchedFlag)
            return true
            
        }
        
    }
    
}

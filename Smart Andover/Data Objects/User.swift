//
//  User.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/13/21.
//

import Foundation

struct User: Hashable {
    
    let email: String
    var firstName: String
    var lastName: String
    private(set) var authority: Authority = .normal
    var points: Int = 0
    
}

//
//  Authority.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/15/21.
//

import Foundation

enum Authority: Int, Codable {
    
    case normal = 0
    case board = 1
    case boardAuthorized = 2
    case president = 3
    
    var isAuthorized: Bool {
        
        //Authorized board member or president
        return rawValue >= 2
        
    }
    
    var title: String {
        switch self {
        case .normal: return "Member"
        case .board: return "Board Member"
        case .boardAuthorized: return "Board Head"
        case .president: return "President"
        }
    }
    
}

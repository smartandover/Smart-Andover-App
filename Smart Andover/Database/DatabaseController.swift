//
//  DatabaseController.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/7/21.
//

import SwiftUI
import Firebase

//TODO: Data such as FunFactsViewData should also be a stored file in the database
class DatabaseController {
    
    static let database = Firestore.firestore()
    static let authentication = Auth.auth()
    
    enum OtherErrors: LocalizedError {
        
        case notAndoverDomain
        case unexpectedData
        case encodingError
        
        case rewardUnavailable
        case insufficientPoints
        
        var errorDescription: String? {
            
            switch self {
                
            case .notAndoverDomain:
                return NSLocalizedString("Cannot sign up using a non-Andover email.", comment: "Signing into the Smart Andover app requires an Andover student account.")
                
            case .unexpectedData:
                return NSLocalizedString("Unable to decode data stored in the database.", comment: "Unexpected data")
                
            case .encodingError:
                return NSLocalizedString("Unable to encode some of the data into the databse.", comment: "Encoding error")
                
            case .rewardUnavailable:
                return NSLocalizedString("This reward is currently unavailable.", comment: "Unavailable")
                
            case .insufficientPoints:
                return NSLocalizedString("You don't have enough points to redeem this reward.", comment: "Insufficient Points")
                
            }
            
        }
        
    }
    
    static func configure () {
        
        FirebaseApp.configure()
        
    }
    
}

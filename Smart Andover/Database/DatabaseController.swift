//
//  DatabaseController.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/7/21.
//

import SwiftUI
import Firebase

//Separate class was created for future versions in case of shift to MongoDB
//TODO: Data such as SmartModelData or FunFactsData should also be a stored file in the database
class DatabaseController {
    
    static let database = Firestore.firestore()
    static let authentication = Auth.auth()
    
    enum OtherErrors: LocalizedError {
        
        case notAndoverDomain
        
        var errorDescription: String? {
            switch self {
            case .notAndoverDomain:
                return NSLocalizedString("Cannot sign up using a non-Andover email.", comment: "Signing into the Smart Andover app requires an Andover student account.")
            }
        }
        
    }
    
    static func signUp (firstName: String, lastName: String, email: String, password: String, errorHandler: @escaping (Smart_Andover.User?, Error?) -> Void) {
        
        guard email.contains("@andover.edu") else {
            errorHandler(nil, OtherErrors.notAndoverDomain)
            return
        }
        
        authentication.createUser(withEmail: email, password: password) { _, error in
            
            if let error = error {
                errorHandler(nil, error)
                print("Error authenticating: \(error)")
            }
            else {
                
                let newUser = User(email: email, firstName: firstName, lastName: lastName)
                errorHandler(newUser, error)
                
                database.collection("Users").document(email.lowercased())
                    .setData([
                        "email"     : email.lowercased(),
                        "firstName" : firstName,
                        "lastName"  : lastName,
                        "authority" : Authority.normal.rawValue,
                        "points"    : 0
                    ])
                
            }
            
        }
        
    }
    
    static func signIn (email: String, password: String, handler: @escaping (Smart_Andover.User?, Error?) -> Void) {
        
        authentication.signIn(withEmail: email, password: password) { result, error in
            
            if let email = result?.user.email {
                
                database.collection("Users").document(email).getDocument { document, error in
                    
                    if let error = error {
                        handler(nil, error)
                    }
                    
                    else if let data = document?.data() {
                        
                        let email = data["email"] as? String ?? "Broken"
                        let fn = data["firstName"] as? String ?? "Broken"
                        let ln = data["lastName"] as? String ?? "Broken"
                        let auth = data["authority"] as? Int ?? 3
                        let points = data["points"] as? Int ?? -10
                        
                        let fetchedUser = User(email: email, firstName: fn, lastName: ln, authority: Authority(rawValue: auth)!, points: points)
                        handler(fetchedUser, error)
                        
                    }
                    else {
                        handler(nil, error)
                    }
                    
                }
                
            }
            else {
                handler(nil, error)
            }
            
        }
        
    }
    
    
    
    
}

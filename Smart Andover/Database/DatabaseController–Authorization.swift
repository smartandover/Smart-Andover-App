//
//  DatabaseControllerAuthorization.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 3/21/22.
//

import Foundation

extension DatabaseController {
    
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

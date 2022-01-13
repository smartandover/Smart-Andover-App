//
//  DatabaseController.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/7/21.
//

import SwiftUI
import Firebase

//Separate class was created for future versions in case of shift to MongoDB
//TODO: Data such as FunFactsViewData should also be a stored file in the database
class DatabaseController {
    
    static let database = Firestore.firestore()
    static let authentication = Auth.auth()
    
    enum OtherErrors: LocalizedError {
        
        case notAndoverDomain
        case unexpectedData
        
        case rewardUnavailable
        case insufficientPoints
        
        var errorDescription: String? {
            switch self {
            case .notAndoverDomain:
                return NSLocalizedString("Cannot sign up using a non-Andover email.", comment: "Signing into the Smart Andover app requires an Andover student account.")
            case .unexpectedData:
                return NSLocalizedString("Unexpected data", comment: "Unable to decode data stored in the database.")
                
            case .rewardUnavailable:
                return NSLocalizedString("Unavailable", comment: "This reward is currently unavailable.")
            case .insufficientPoints:
                return NSLocalizedString("Insufficent Points", comment: "You don't have enough points to redeem this reward.")
            }
        }
        
    }
    
    static func configure () {
        
        FirebaseApp.configure()
        
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
    
    static func getRewardData (handler: @escaping ([Reward]?) -> Void) {
        
        database.collection("Rewards")
            .getDocuments { query, error in
                
                guard let query = query, error == nil else {
                    handler(nil)
                    return
                }
                
                var rewardDocuments = query.documents.map({ document -> Reward? in
                    
                    guard
                        //
                        let name = document.data()["name"] as? String,
                        let pointsCost = document.data()["pointsCost"] as? Int,
                        let available = document.data()["available"] as? Bool
                        //
                    else { return nil }
                    
                    let imageData = (document.data()["imageData"] as? Data) ?? Data()
                    
                    return Reward(id: document.documentID, available: available, name: name, imageData: imageData, pointsCost: pointsCost)
                    
                })
                
                rewardDocuments.removeAll(where: {$0 == nil})
                
                handler((rewardDocuments as! [Reward]))
                
            }
        
    }
    
    static func redeemPoints (user: User, reward: Reward, handler: @escaping (Error?) -> Void) {
        
        database.collection("Rewards")
            .document(reward.id)
            .getDocument { document, error in
                
                guard let document = document, error == nil else {
                    handler(error)
                    return
                }
                
                guard let available = document.data()?["available"] as? Bool, available else {
                    handler(OtherErrors.rewardUnavailable)
                    return
                }
                
                guard let cost = document.data()?["pointsCost"] as? Int else {
                    handler(OtherErrors.unexpectedData)
                    return
                }
                
                guard user.points >= cost else {
                    handler(OtherErrors.insufficientPoints)
                    return
                }
                
                //Add points
                database
                    .collection("Users")
                    .document(user.email)
                    .updateData(["points": FieldValue.increment(Double(-cost))])
                
                //Add to accepted photos
                database
                    .collection("Orders")
                    .addDocument(data: [
                        "buyer": user.email,
                        "reward": reward.name,
                        "pointsUsed": cost,
                        "dateOrdered": Date()
                    ])
                
                
            }
        
    }
    
    static func getOrders (email: String, handler: @escaping ([Coupon]?) -> Void) {
        
        database
            .collection("Orders")
            .whereField("buyer", isEqualTo: email)
            .getDocuments { query, error in
                
                guard let query = query, error == nil else {
                    handler(nil)
                    return
                }
                
                let orders = query.documents.map({ document -> Coupon in
                    
                    return Coupon(reward: document.data()["reward"] as! String, orderID: document.documentID)
                    
                })
                
                handler(orders)
                
            }
        
    }
    
}

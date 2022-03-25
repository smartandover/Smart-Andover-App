//
//  DatabaseControllerRewarding.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 3/21/22.
//

import UIKit
import Firebase

extension DatabaseController {
    
    static func addReward (name: String, cost: Int, active: Bool, image: UIImage, handler: @escaping (Error?) -> Void) {
        
        guard let data = image.jpegData(quality: .medium)
        else {
            handler(OtherErrors.encodingError)
            return
        }
        
        database.collection("Rewards")
            .addDocument(data: [
                "available" : active,
                "imageData" : data,
                "name" : name,
                "pointsCost" : cost
            ])
        
    }
    
    static func deleteReward (id: String, handler: @escaping (Error?) -> Void) {
        
        database.collection("Rewards").document(id)
            .delete(completion: handler)
        
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
                    
                    return Reward(id: document.documentID,
                                  available: available,
                                  name: name,
                                  imageData: imageData,
                                  pointsCost: pointsCost)
                    
                })
                
                rewardDocuments.removeAll(where: {$0 == nil})
                
                handler((rewardDocuments as! [Reward]))
                
            }
        
    }
    
    static func buyCoupon (user: User, reward: Reward, handler: @escaping (Error?) -> Void) {
        
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
                
                guard let rewardData = try? JSONEncoder().encode(reward) else {
                    handler(OtherErrors.encodingError)
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
                        "reward": rewardData,
                        "pointsUsed": cost,
                        "dateOrdered": Date()
                    ])
                
                handler(error)
                
                
            }
        
    }
    
    static func useCoupon (id couponID: String, completion: ((Error?) -> Void)? = nil) {
        
        database
            .collection("Orders")
            .document(couponID)
            .delete(completion: completion)
        
    }
    
    static func getCoupon (id: String, handler: @escaping (Coupon?, Error?) -> Void) {
        
        database
            .collection("Orders")
            .document(id)
            .getDocument { document, error in
                
                guard let documentData = document?.data(), error == nil else {
                    handler(nil, error)
                    return
                }
                
                guard
                    //
                    let buyer = documentData["buyer"] as? String,
                    let dateOrdered = documentData["dateOrdered"] as? Firebase.Timestamp,
                    let pointsUsed = documentData["pointsUsed"] as? Int,
                    let rewardData = documentData["reward"] as? Data,
                    let reward = try? JSONDecoder().decode(Reward.self, from: rewardData)
                    //
                else {
                    handler(nil, OtherErrors.unexpectedData)
                    return
                }
                
                let coupon = Coupon(id: id,
                                    buyer: buyer,
                                    dateOrdered: dateOrdered.dateValue(),
                                    pointsUsed: pointsUsed,
                                    reward: reward)
                handler(coupon, nil)
                
            }
        
    }
    
    static func getCouponsForUser (email: String, handler: @escaping ([Coupon]?) -> Void) {
        
        database
            .collection("Orders")
            .whereField("buyer", isEqualTo: email)
            .getDocuments { query, error in
                
                guard let query = query, error == nil else {
                    handler(nil)
                    return
                }
                
                var orders = query.documents.map({ document -> Coupon? in
                    
                    guard
                        //
                        let buyer = document.data()["buyer"] as? String,
                        let dateOrdered = document.data()["dateOrdered"] as? Firebase.Timestamp,
                        let pointsUsed = document.data()["pointsUsed"] as? Int,
                        let rewardData = document.data()["reward"] as? Data,
                        let reward = try? JSONDecoder().decode(Reward.self, from: rewardData)
                        //
                    else { return nil }
                    
                    return Coupon(id: document.documentID,
                                  buyer: buyer,
                                  dateOrdered: dateOrdered.dateValue(),
                                  pointsUsed: pointsUsed,
                                  reward: reward)
                    
                })
                
                orders.removeAll(where: {$0 == nil})
                
                handler((orders as! [Coupon]))
                
            }
        
    }
    
}

//
//  PhotoSubmissions.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/15/21.
//

import SwiftUI
import Firebase

extension DatabaseController {
    
    static func uploadPhoto (user: Smart_Andover.User, photo: UIImage, completion: @escaping (Error?) -> Void) {
        
        guard let compressedPhoto = photo.jpegData(quality: .verylow)
        else {
            print("Photo couldn't be encoded")
            return
        }
        
        print(compressedPhoto)
        
        database
            .collection("PendingPhotos")
            .addDocument(data: [
                "photoData"     : compressedPhoto,
                "dateSubmitted" : Date(),
                "userEmail"     : user.email
            ], completion: completion)
        
    }
    
    static func getPendingPhotos (handler: @escaping ([PhotoDocument]?) -> Void) {
        
        database
            .collection("PendingPhotos")
            //Oldest photos get priority
            .order(by: "dateSubmitted")
            //Reduce Firebase read bills in potential future
            .limit(to: 5)
            .getDocuments { query, error in
            
            if error != nil {
                //handle error
            }
            
            guard let query = query else {
                handler(nil)
                return
            }
            
            var photoDocuments = query.documents.map({ document -> PhotoDocument? in
                
                guard
                    let photoData = document.data()["photoData"] as? Data,
                    let dateSubmitted = document.data()["dateSubmitted"] as? Timestamp,
                    let userEmail = document.data()["userEmail"] as? String
                else { return nil }
                
                return PhotoDocument(id: document.documentID, photoData: photoData, dateSubmitted: dateSubmitted.dateValue(), userEmail: userEmail)
                
            })
            
            photoDocuments.removeAll(where: {$0 == nil})
            
            handler((photoDocuments as! [PhotoDocument]))
            
        }
        
    }
    
    static func resolvePhotoDocument (document: PhotoDocument, approved: Bool, points pointsGranted: Int, reviewerEmail: String, comments: String?) {
        
        database.collection("PendingPhotos").document(document.id).delete()
        
        if approved {
            
            //Add points
            database
                .collection("Users")
                .document(document.userEmail)
                .updateData(["points": FieldValue.increment(Double(pointsGranted))])
            
        }
        
        //Add to accepted photos
        database
            .collection("ResolvedPhotos")
            .document(document.id)
            .setData([
                "photoData"     : document.photoData,
                "dateSubmitted" : document.dateSubmitted,
                "userEmail"     : document.userEmail,
                "reviewerEmail" : reviewerEmail,
                "approved"      : approved,
                "pointsGranted"  : pointsGranted,
                "comments"      : comments ?? ""
            ])
        
        
    }
    
    
    //Cleanup: Enum for rejected/accepted/pending photos... function is the same, collection name is different
    static func getResolvedPhotos (email: String, handler: @escaping ([ResolvedPhotoDocument]?) -> Void) {
        
        database
            .collection("ResolvedPhotos")
            .whereField("userEmail", isEqualTo: email)
            .getDocuments { query, error in
                
                guard let query = query, error == nil else {
                    handler(nil)
                    return
                }
                
                var photoDocuments = query.documents.map({ document -> ResolvedPhotoDocument? in
                    
                    guard
                        //
                        let photoData = document.data()["photoData"] as? Data,
                        let dateSubmitted = document.data()["dateSubmitted"] as? Timestamp,
                        let userEmail = document.data()["userEmail"] as? String,
                        //
                        let reviewerEmail = document.data()["reviewerEmail"] as? String,
                        let approved = document.data()["approved"] as? Bool,
                        let pointsGranted = document.data()["pointsGranted"] as? Int,
                        let comments = document.data()["comments"] as? String
                        //
                    else { return nil }
                    
                    return ResolvedPhotoDocument(id: document.documentID,
                                                 photoData: photoData,
                                                 dateSubmitted: dateSubmitted.dateValue(),
                                                 userEmail: userEmail,
                                                 reviewerEmail: reviewerEmail,
                                                 approved: approved,
                                                 pointsGranted: pointsGranted,
                                                 comments: comments)
                    
                })
                
                photoDocuments.removeAll(where: {$0 == nil})
                
                handler((photoDocuments as! [ResolvedPhotoDocument]))
                
            }
        
    }
    
}

//
//  PhotoDocument.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/18/21.
//

import Foundation

struct PhotoDocument: Hashable {
    let id: String
    let photoData: Data
    let dateSubmitted: Date
    let userEmail: String
}

struct ResolvedPhotoDocument: Hashable {
    
    let id: String
    let photoData: Data
    let dateSubmitted: Date
    let userEmail: String
    
    let reviewerEmail: String
    let approved: Bool
    let pointsGranted: Int
    let comments: String
    
}

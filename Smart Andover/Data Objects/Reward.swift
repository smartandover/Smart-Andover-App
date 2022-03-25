//
//  Reward.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI

struct Reward: Codable, Hashable, Identifiable {
    
    let id: String
    let available: Bool
    let name: String
    let imageData: Data
    let pointsCost: Int
    
    var image: Image {
        return Image(uiImage: UIImage(data: imageData) ?? UIImage(named: "SmartAndoverSquare")!)
    }
    
}

//
//  Coupon.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI

struct Coupon: Hashable, Identifiable {
    
    ///The order ID of the coupon.
    let id: String
    ///The email of the user who holds this coupon.
    let buyer: String
    ///The date this coupon was bought.
    let dateOrdered: Date
    ///The amount of points used to redeem this coupon.
    let pointsUsed: Int
    ///The reward associated with this coupon.
    let reward: Reward
    
    ///Image data (PNG format) for the QR code associated with the coupon's ID.
    let QRData: Data
    
    init (id: String, buyer: String, dateOrdered: Date, pointsUsed: Int, reward: Reward) {
        
        self.id = id
        self.buyer = buyer
        self.dateOrdered = dateOrdered
        self.pointsUsed = pointsUsed
        self.reward = reward
        
        
        let data = id.data(using: String.Encoding.ascii)
        
        let generator = CIFilter(name: "CIQRCodeGenerator")!
        
        generator.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        let qrImage = generator.outputImage!.transformed(by: transform)
        
        self.QRData = UIImage(ciImage: qrImage).pngData()!
        
    }
    
}

//
//  Coupon.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI

struct Coupon: Hashable {
    
    let reward: String
    let orderID: String
    
    var QRData: Data {
        
        let data = orderID.data(using: String.Encoding.ascii)
        
        let generator = CIFilter(name: "CIQRCodeGenerator")!
        
        generator.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        let qrImage = generator.outputImage!.transformed(by: transform)
        
        return UIImage(ciImage: qrImage).pngData()!
        
    }
    
}

//
//  ImageToJPEG.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/7/21.
//

import UIKit
import SwiftUI

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case verylow  = 0
        case low      = 0.25
        case medium   = 0.5
        case high     = 0.75
        case veryHigh = 0.1
    }
    
    ///Caps data at around 10KB
    func jpegData (quality: JPEGQuality) -> Data? {
        
        let maxSize: CGFloat = 400
        let maxDimension = min(self.size.width, self.size.height)
        
        var newSize = self.size
        
        if maxDimension > maxSize {
            
            let adjustmentScale = maxSize / maxDimension
            
            newSize.width *= adjustmentScale
            newSize.height *= adjustmentScale
            
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        self.draw(in: rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: quality.rawValue)
        
        UIGraphicsEndImageContext()
        
        return imageData
        
    }
    
}

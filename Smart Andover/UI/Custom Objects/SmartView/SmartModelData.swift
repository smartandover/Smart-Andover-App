//
//  SmartModelData.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/7/21.
//

import SwiftUI

extension SmartModel {
    
    static let models: [SmartModel] = [     .eat,    .drink,    .clean,
                                         .reduce,    .reuse,  .recycle,
                                       .innovate,    .share,  .support,]
    
    
    static var eat: SmartModel {
        return SmartModel(theme: .theme, title: "Eat", symbol: Image(systemName: "circle"), text: "Try being vegetarian.")
    }
    
    static var drink: SmartModel {
        return SmartModel(theme: .theme, title: "Drink", symbol: Image(systemName: "circle"), text: "Drink healthy. And efficiently!")
    }
    
    static var clean: SmartModel {
        return SmartModel(theme: .theme, title: "Clean", symbol: Image(systemName: "circle"), text: "Clean the environment and stuff.")
    }
    
    
    
    
    
    static var reduce: SmartModel {
        return SmartModel(theme: .green, title: "Reduce", symbol: Image(systemName: "printer"), text: "Reduce things like gas.")
    }
    
    static var reuse: SmartModel {
        return SmartModel(theme: .green, title: "Reuse", symbol: Image(systemName: "leaf.arrow.triangle.circlepath"), text: "Reuse some stuff. Make art or something.")
    }
    
    static var recycle: SmartModel {
        return SmartModel(theme: .green, title: "Recycle", symbol: Image(systemName: "arrow.3.trianglepath"), text: "Recycle bro")
    }
    
    
    
    
    
    static var innovate: SmartModel {
        return SmartModel(theme: .yellow, title: "Innovate", symbol: Image(systemName: "lightbulb"), text: "Innovate and stuff.")
    }
    
    static var share: SmartModel {
        return SmartModel(theme: .yellow, title: "Share", symbol: Image(systemName: "paperplane"), text: "Clean the environment and stuff.")
    }
    //bubble.left.and.exclamationmark.bubble.right
    
    static var support: SmartModel {
        return SmartModel(theme: .yellow, title: "Support", symbol: Image(systemName: "hands.sparkles"), text: "Clean the environment and stuff.")
    }
    
}

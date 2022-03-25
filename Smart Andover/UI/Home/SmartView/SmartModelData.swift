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
        return SmartModel(theme: .theme, title: "Eat", symbol: Image(systemName: "circle"), text: "Plant-rich diets reduce emissions and tend to be healthier, leading to lower rates of chronic disease. Do you have the willpower to change your own diet?")
    }
    
    static var drink: SmartModel {
        return SmartModel(theme: .theme, title: "Drink", symbol: Image(systemName: "circle"), text: "If everyone in the U.S. switched over to using a reusable drinking container for one year, that would save enough crude oil to power a million cars for a year. Let's see you use those campus water fountains!")
    }
    
    static var clean: SmartModel {
        return SmartModel(theme: .theme, title: "Clean", symbol: Image(systemName: "circle"), text: "Littering is a problem everywhere. See some trash on the sidewalk? Be a good Samaritan and take care of it!")
    }
    
    
    
    
    
    static var reduce: SmartModel {
        return SmartModel(theme: .green, title: "Reduce", symbol: Image(systemName: "printer"), text: "Running tap water for 2 minutes is equivalent to 3-5 gallons of water. Try controlling your usage of things like running tapwater and leaving lights on.")
    }
    
    static var reuse: SmartModel {
        return SmartModel(theme: .green, title: "Reuse", symbol: Image(systemName: "leaf.arrow.triangle.circlepath"), text: "Reuse some stuff. Make art or something.")
    }
    
    static var recycle: SmartModel {
        return SmartModel(theme: .green, title: "Recycle", symbol: Image(systemName: "arrow.3.trianglepath"), text: "About 68 million trees are cut down each year to produce paper and paper products. If you don’t recycle the paper you use, it all ends up in the landfill.")
    }
    
    
    
    
    
    static var innovate: SmartModel {
        return SmartModel(theme: .yellow, title: "Innovate", symbol: Image(systemName: "lightbulb"), text: "90% people said they would recycle if it were “easier”. Any ideas on how to do this?")
    }
    
    static var share: SmartModel {
        return SmartModel(theme: .yellow, title: "Share", symbol: Image(systemName: "paperplane"), text: "Spread the word to your friends!")
    }
    //bubble.left.and.exclamationmark.bubble.right
    
    static var support: SmartModel {
        return SmartModel(theme: .yellow, title: "Support", symbol: Image(systemName: "hands.sparkles"), text: "We all have to do our part. Don't feel embarassed to encourage your peers to be actively more sustainble!")
    }
    
}

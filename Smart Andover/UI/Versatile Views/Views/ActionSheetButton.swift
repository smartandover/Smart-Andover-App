//
//  ActionSheetButton.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/15/21.
//

import SwiftUI

struct ActionSheetButton <Label: View> : View {
    
    let label: Label
    let actionSheet: ActionSheet
    
    @State private var isShowing: Bool = false
    
    init (label: Label, sheetTitle title: Text, sheetMessage message: Text? = nil, buttons: [ActionSheet.Button]) {
        
        self.label = label
        self.actionSheet = ActionSheet(title: title, message: message, buttons: buttons)
        
    }
    
    init (@ViewBuilder label: () -> Label, sheetTitle title: Text, sheetMessage message: Text? = nil, buttons: [ActionSheet.Button]) {
        
        self.label = label()
        self.actionSheet = ActionSheet(title: title, message: message, buttons: buttons)
        
    }
    
    var body: some View {
        
        Button(action: { isShowing = true }, label: { label } )
            .actionSheet(isPresented: $isShowing, content: {actionSheet})
        
    }
    
}

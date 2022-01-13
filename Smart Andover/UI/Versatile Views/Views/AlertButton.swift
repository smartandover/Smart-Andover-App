//
//  AlertButton.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/14/21.
//

import SwiftUI

struct AlertButton<Label: View>: View {
    
    let button: Button<Label>
    let alert: Alert
    
    init (label: Label, title: Text, message: Text? = nil, primaryButton: Alert.Button, secondaryButton: Alert.Button) {
        self.button = Button(action: {}, label: {label})
        
        self.alert = Alert(title: title,
                           message: message,
                           primaryButton: primaryButton,
                           secondaryButton: secondaryButton)
        
    }
    
    init (label: Label, title: Text, message: Text? = nil, dismissButton: Alert.Button = .cancel()) {
        self.button = Button(action: {}, label: {label})
        
        self.alert = Alert(title: title,
                           message: message,
                           dismissButton: dismissButton)
        
    }
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        button
            .simultaneousGesture(TapGesture().onEnded { showAlert = true })
            .alert(isPresented: $showAlert, content: {alert})
        
    }
    
}

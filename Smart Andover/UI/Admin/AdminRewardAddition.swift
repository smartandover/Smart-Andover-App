//
//  AdminRewardAddition.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 2/10/22.
//

import SwiftUI

struct AdminRewardAddition: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.currentUser) private var moderator
    
    @State private var uiImage: UIImage?
    @State private var name: String = ""
    @State private var cost: String = ""
    @State private var available: Bool = false
    
    @State private var error: Error?
    @State private var showLibrary = false;
    
    private var image: Image {
        if let uiImage = uiImage { return Image(uiImage: uiImage) }
        else { return Image(systemName: "photo") }
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Button(action: { showLibrary = true }, label: {
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 50, minHeight: 50)
                    .padding(.vertical, 20)
            })
            .sheet(isPresented: $showLibrary) {
                ImagePicker(isShown: $showLibrary, image: $uiImage, imageSource: .photoLibrary, allowsEditing: true)
            }
            
            Divider()
            
            TextField("Name", text: $name)
                .requiredField(.constant(true))
            
            Divider()
            
            TextField("Cost", text: $cost)
                .keyboardType(.asciiCapableNumberPad)
                .requiredField(.constant(true))
            
            Divider()
            
            Toggle("Available", isOn: $available)
                .requiredField(.constant(true))
            
            AlertButton(label: Text("Confirm"),
                        title: Text("Add Reward"),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text("Confirm").foregroundColor(.green).bold(), action: confirmAddition))
                .buttonStyle(BarButtonStyle(tint: .green))
                .padding(.horizontal)
            
            // Cancel button
            AlertButton(label: Text("Close"),
                        title: Text("Close?"),
                        message: Text("This information will be lost."),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text("Close"), action: dismiss))
                .foregroundColor(.blue)
                .padding(.horizontal)
            
        }
        .padding()

        
    }
    
    func confirmAddition () {
        
        DatabaseController.addReward(name: name, cost: Int(cost.filter{$0.isNumber})!, active: available, image: uiImage ?? UIImage(named: "SmartAndoverSquare")!) { error in
            
            uiImage = nil
            name = ""
            cost = ""
            available = false
            
            dismiss()
            
        }
        
    }
    
    func dismiss () {
        presentationMode.wrappedValue.dismiss()
    }
    
}

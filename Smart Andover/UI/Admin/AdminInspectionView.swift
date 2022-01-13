//
//  Examine.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/17/21.
//

import SwiftUI

struct AdminInspectionView: View {
    
    let document: PhotoDocument
    
    @Environment(\.currentUser) private var moderator
    @Binding var selection: PhotoDocument?
    
    @State private var approved: Bool = false
    @State private var showMinimumPointError: Bool = false
    @State private var points: Float = 0
    @State private var comments: String = ""
    
    private var image: Image {
        return Image(uiImage: UIImage(data: document.photoData) ?? UIImage(named: "SmartAndoverSquare")!)
    }
    
    var body: some View {
        
        VStack {
            
            Button("Close", action: { selection = nil })
                .foregroundColor(.theme)
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .padding()
            
            image.resizable()
                .scaledToFit()
                .shadow(color: .themeDark, radius: 5)
                .padding(.bottom)
            
            Toggle("Approved: " + String(approved ? "Yes" : "No "), isOn: $approved.animation())
                .toggleStyle(SwitchToggleStyle(tint: .green))
            
            Divider()
            
            if approved {
                HStack {
                    Text("Points: " + String(describing: Int(points)))
                    Slider(value: $points, in: 0...20)
                }
                
                Divider()
                
            }
            
            ZStack {
                if comments.isEmpty {
                    Text("Comments")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                TextField("Comments", text: $comments)
                
            }
            
            Divider()
            
            AlertButton(label: Text("Resolve"),
                        title: Text("Resolve this photo?"),
                        message: Text("This action cannot be undone. Please make sure all fields are satisifed correctly."),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("Confirm").foregroundColor(.red), action: sendReview))
                .buttonStyle(BarButtonStyle(tint: .red))
            
            
            Spacer()
            
        }
        .padding(40)
        
    }
    
    func sendReview () {
        
        DatabaseController.resolvePhotoDocument(document: document,
                                                approved: approved,
                                                points: Int(points),
                                                reviewerEmail: moderator.wrappedValue!.email,
                                                comments: comments.isEmpty ? nil : comments)
        
        selection = nil
        
    }
    
}

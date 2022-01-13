//
//  SubmissionsView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI

struct ProfileSubmissionsView: View {
    
    @Environment(\.currentUser) var user
    @State private var submittedPhotos: [ResolvedPhotoDocument]?
    
    var body: some View {
        
        if let submittedPhotos = submittedPhotos {
            
            TabView {
                
                ForEach(submittedPhotos, id: \.self) { document in
                    
                    TabLink(tabItem: Image(systemName: "circle.fill")) {
                        
                        Image(uiImage: UIImage(data: document.photoData) ?? UIImage(named: "SmartAndoverSquare")!)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .overlay(
                                
                                ZStack {
                                    
                                    Image(systemName: document.approved ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                                        .font(.callout)
                                        .foregroundColor(document.approved ? .green : .red)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        .padding()
                                    
                                    if !document.comments.isEmpty {
                                        Text(document.comments)
                                            .font(.caption2.bold())
                                            .foregroundColor(.themeDark)
                                            .padding(10)
                                            .background(ChatBubble().foregroundColor(.white).shadow(radius: 5))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                            .offset(x: 20, y: 20)
                                    }
                                }
                            )
                            .padding(.bottom, 40)
                        
                    }
                    
                }
                
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        
        else {
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    DatabaseController.getResolvedPhotos(email: user.wrappedValue!.email) { documents in
                        submittedPhotos = documents
                    }
                }
            
        }
        
    }
    
}

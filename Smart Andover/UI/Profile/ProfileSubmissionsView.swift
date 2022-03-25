//
//  SubmissionsView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI

struct ProfileSubmissionsView: View {
    
    @Environment(\.currentUser) private var user
    @State private var submittedPhotos: [ResolvedPhotoDocument]?
    
    var body: some View {
        
        if let submittedPhotos = submittedPhotos, submittedPhotos.count > 0 {
            
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
        
        else if submittedPhotos != nil {
            
            VStack {
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.themeLight)
                    .padding()
                
                Text("Looks like none of your submissions have been reviewed so far. Try sending some through the Home page!")
                    .foregroundColor(.themeDark)
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .multilineTextAlignment(.center)
                
            }
            .padding().padding()
            .frame(height: 300)
            
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

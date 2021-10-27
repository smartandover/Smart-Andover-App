//
//  HomeView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/12/21.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.currentUser) var user
    @State private var showImageSelector = false
    
    var body: some View {
        
        FadeScrollView(barLabel: {
            
            Label("Available Points: \(user.wrappedValue!.points)", systemImage: "rosette")
                .font(.caption.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .foregroundColor(.themeDark)
                .background(Color.themeLight)
            
        }, fullLabel: {
            
            ZStack {
                
                VStack(spacing: 0) {
                    
                    Text("Available Points")
                        .foregroundColor(.themeDark)
                        .font(.system(size: 15, weight: .light, design: .rounded))
                    
                    Text("\(user.wrappedValue!.points)")
                        .foregroundColor(.themeDark)
                        .font(.system(size: 55, weight: .bold, design: .rounded))
                    
                    Label("Welcome back \(user.wrappedValue!.firstName)!", systemImage: "rosette")
                        .foregroundColor(.themeDark)
                    
                }
                
                VStack {
                    FunFacts()
                        .font(.caption2)
                        .foregroundColor(.themeDark)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        //Size of frame, plus a little more
                        .offset(y: 225)
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            
        }, scrollContent: {
            
            Label("Earn Points", systemImage: "leaf")
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.themeDark)
                .padding(.leading)
            
            SmartSlidesView()
                .frame(height: 175)
            
            
            Button {
                showImageSelector = true
            } label: {
                Label("Upload Photo", systemImage: "camera.on.rectangle")
            }
            .buttonStyle(BarButtonStyle(tint: .theme))
            .padding(.horizontal)
            .fullScreenCover(isPresented: $showImageSelector, content: { PhotoCaptureView().background(Color.systemBackground) })
            
            
            Label("Rewards", systemImage: "gift")
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            RewardsView()
                .padding(.horizontal)
            
            
            
        })
        
    }
    
}

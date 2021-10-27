//
//  FadeScrollView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/15/21.
//

import SwiftUI

private struct ScrollDistance: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}

struct FadeScrollView <Label: View, Bar: View, Content: View>: View {
    
    var fullLabel: () -> Label
    var barLabel: () -> Bar
    var scrollContent: () -> Content
    
    init (@ViewBuilder barLabel: @escaping () -> Bar, @ViewBuilder fullLabel: @escaping () -> Label, @ViewBuilder scrollContent: @escaping () -> Content) {
        self.barLabel = barLabel
        self.fullLabel = fullLabel
        self.scrollContent = scrollContent
    }
    
    @State private var initialOffset: CGFloat?
    @State private var offset: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
                barLabel()
                    .opacity(Double(-offset - 175) / 75)
                Spacer()
            }
            .zIndex(2)
        
            ScrollView (showsIndicators: false) {
                
                VStack(spacing: 0) {
                
                    GeometryReader { proxy in
                        Color.clear
                            .frame(height: 0)
                            .preference(key: ScrollDistance.self, value: proxy.frame(in: .named("scrollID")).minY)
                            .onPreferenceChange(ScrollDistance.self) { newPos in
                                if initialOffset == nil {
                                    initialOffset = newPos
                                }
                                else {
                                    offset = newPos - initialOffset!
                                }
                                
                            }
                    }
                        
                    fullLabel()
                        .offset(y: -offset * 0.5)
                        .opacity(Double(offset / 100) + 1.5)
                    
                    scrollContent()
                        .padding(.vertical)
                        .background(Color.systemBackground)
//                        .bubbleStyle(padding: 0)
                    
//                    LinearGradient(gradient: Gradient(colors: [.systemBackground, .themeLight]), startPoint: .top, endPoint: .bottom)
//                        .frame(height: 100)
                    
                }
                
            }
            .coordinateSpace(name: "scrollID")
            .ignoresSafeArea()
            .background(Color.themeLight)
            
        }
        
    }
    
}

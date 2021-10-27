//
//  SmartView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/4/21.
//

import SwiftUI

struct SmartView: View {
    
    @Namespace private var namespace
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    let content: AnyView
    
    init <V: View> (@ViewBuilder content: () -> V) {
        self.content = AnyView(content())
    }
    
    var body: some View {
        
        ZStack {
            
                
            if coordinator.isShowingDetails {
                coordinator.details().zIndex(2)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            else {
                content.namespace(namespace)
                    .environmentObject(coordinator)
            }
            
        }
        
    }
    
}

extension SmartView {
    
    class Coordinator: ObservableObject {
        
        @Published var isShowingDetails: Bool = false
        @Published var details: () -> AnyView = { AnyView(EmptyView()) }
        
    }
    
}

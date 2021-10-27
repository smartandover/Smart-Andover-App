//
//  SmartCard.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/4/21.
//

import SwiftUI

struct SmartCard: View {
    
    @Environment(\.namespace) private var namespace
    @EnvironmentObject private var coordinator: SmartView.Coordinator
    @Namespace private var localNamespace
    
    let id: String
    let theme: Color
    let title: String
    let symbol: Image
    let text: String
    
    var body: some View {
        
        preview().onTapGesture {
            withAnimation {
                coordinator.details = {AnyView(details())}
                coordinator.isShowingDetails = true
            }
        }
        
    }
    
    
    init (id: String, theme: Color, title: String, symbol: Image, text: String) {
        self.id = id
        self.theme = theme
        self.title = title
        self.symbol = symbol
        self.text = text
    }
    
    init (id: String, model: SmartModel) {
        self.id = id
        self.theme = model.theme
        self.title = model.title
        self.symbol = model.symbol
        self.text = model.text
    }
    
    
    @ViewBuilder func preview () -> some View {
        
        ZStack {
            
            let gradient = Gradient(colors: [theme.opacity(0.6), theme.opacity(0.3)])
            RoundedRectangle(cornerRadius: 35)
                .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
//                .fill(theme.opacity(0.3))
                .matchedGeometryEffect(id: id + ".background", in: namespace ?? localNamespace)
            
            VStack (spacing: 5) {
                
                symbol.resizable()
                    .font(.callout.weight(.light))
                    .matchedGeometryEffect(id: id + ".image", in: namespace ?? localNamespace)
                    .aspectRatio(1, contentMode: .fit)
                
                Text(title)
                    .font(.headline)
                    .matchedGeometryEffect(id: id + ".title", in: namespace ?? localNamespace)
                    .frame(maxWidth: .infinity)
                
                ScrollView {
                    Text(text).font(.subheadline)
                }
                .matchedGeometryEffect(id: id + ".text", in: namespace ?? localNamespace)
                .frame(maxWidth: .infinity, maxHeight: 0, alignment: .topLeading)
                .clipped()
                
            }
            .padding(.vertical, 10)
            //For TupleViews
            .id(id)
            
            //Blank shape for  the 'X' button to animate
            Circle()
                .matchedGeometryEffect(id: id + ".close", in: namespace ?? localNamespace)
                .hidden()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
        }
        
    }
    
    @ViewBuilder func details () -> some View {
        
        ZStack {
            
            BlurView()
                .onTapGesture(perform: dismiss)
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill().foregroundColor(theme.opacity(0.7))
                    .matchedGeometryEffect(id: id + ".background", in: namespace ?? localNamespace)
                
                
                VStack (spacing: 5) {
                    
                    symbol.resizable()
                        .matchedGeometryEffect(id: id + ".image", in: namespace ?? localNamespace)
                        .aspectRatio(1, contentMode: .fit)
                        .padding()
                    
                    Text(title)
                        .matchedGeometryEffect(id: id + ".title", in: namespace ?? localNamespace)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .font(.headline)
                    
                    ScrollView {
                        Text(text).font(.subheadline)
                    }
                    .matchedGeometryEffect(id: id + ".text", in: namespace ?? localNamespace)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .clipped()
                    
                }
                .padding()
                
                Button(action: dismiss, label: {
                    Image(systemName: "multiply.circle.fill")
                        .matchedGeometryEffect(id: id + ".close", in: namespace ?? localNamespace)
                        .font(.title.weight(.regular))
                        .foregroundColor(.secondary)
                        .padding()
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
            }
//            .frame(width: 350, height: 400, alignment: .center)
            
        }
        
    }
    
    func dismiss () {
        withAnimation {
            coordinator.details = {AnyView(EmptyView())}
            coordinator.isShowingDetails = false
        }
    }
    
    
}

//
//  SmartSlideShow.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/2/21.
//

import SwiftUI

private enum DragState {
    case inactive
    case dragging (_ translation: CGSize)
}

struct SmartSlidesView: View {
    
    @State private var gesture = DragState.inactive
    @State private var selection: Int = 0
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    
    @State private var models = SmartModel.models
    
    var body: some View {
        
        ZStack {
            
            ForEach(0..<models.count) { index in
                
                let model = models[index]
                
                SmartCard(model: model)
                    .frame(width: 290)
                    .offset(x: CGFloat(index * 300) - offset)
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .highPriorityGesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ translation in
                    offset = lastOffset - translation.translation.width
                })
                .onEnded({ translation in
                    
                    withAnimation (.easeOut(duration: 0.25)) {
                        
                        let predictedOffset = (lastOffset - translation.predictedEndTranslation.width)
                        let newSelection = Int(round(predictedOffset / 300))
                        
                        let difference = newSelection - selection
                        
                        if difference >= 1 {
                            selection = next()
                        }
                        if difference <= -1 {
                            selection = last()
                        }
                        
                        offset = CGFloat(300 * selection)
                        
                        lastOffset = offset
                        
                    }
                    
                })
        )
        
    }
    
    #warning("Figure out a carousel effect.")
    func next () -> Int {
        if selection + 1 > models.count - 1 {
            return selection
//            return 0
        }
        else {
            return selection + 1
        }
    }
    
    func last () -> Int {
        if selection - 1 < 0 {
            return selection
//            return models.count - 1
        }
        else {
            return selection - 1
        }
    }
    
    
    @ViewBuilder func SmartCard (model: SmartModel) -> some View {
        
        GeometryReader { proxy in
            
            HStack {
                
                model.symbol.resizable()
                    .foregroundColor(.primary)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: proxy.size.width / 4, maxHeight: proxy.size.height, alignment: .center)
                    .padding()
                
                Spacer()
                
                VStack {
                    
                    Text(model.title)
                        .font(.headline.bold())
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(model.text)
                        .foregroundColor(.primary)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .bubbleStyle(color: model.theme)
            
        }
        
    }
    
}

struct SmartInformationView: View {
    
    var body: some View {
        
        SmartView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]) {

                ForEach(0..<SmartModel.models.count) { index in
                    SmartCard(id: String(index), model: SmartModel.models[index])
                        .aspectRatio(contentMode: .fit)
                }

            }
            .layoutPriority(-1)
            .padding(.horizontal)
        }
        
    }
    
}

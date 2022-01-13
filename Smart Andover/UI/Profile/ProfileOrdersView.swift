//
//  ProfileOrdersView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI
import MobileCoreServices

struct ProfileOrdersView: View {
    
    @Environment(\.currentUser) var user
    @State private var coupons: [Coupon]?
    
    var body: some View {
        
        if let coupons = coupons {
            
            let layout = [GridItem(.flexible()),
                          GridItem(.flexible())]
            LazyVGrid (columns: layout) {
            
                ForEach(coupons, id: \.self) { coupon in
                    
                    VStack {
                        
                        Image(uiImage: UIImage(data: coupon.QRData) ?? UIImage()).resizable()
                            .scaledToFit()
                            .padding(.horizontal)
                            
                        Text(coupon.reward).bold()
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                        
                    }
                    .foregroundColor(.themeDark)
                    .bubbleStyle()
                    .contextMenu(menuItems: {
                        Text(coupon.orderID)
                        Button("Copy Order ID") {
                            UIPasteboard.general.setValue(coupon.orderID, forPasteboardType: kUTTypePlainText as String)
                        }
                    })
                    
                }
                
            }
            .padding(.horizontal)
            
        }
        
        else {
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    DatabaseController.getOrders(email: user.wrappedValue!.email) { documents in
                        coupons = documents
                    }
                }
            
        }
        
    }
    
}

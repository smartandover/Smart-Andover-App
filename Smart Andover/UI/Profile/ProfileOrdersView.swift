//
//  ProfileOrdersView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/3/21.
//

import SwiftUI
import MobileCoreServices

struct ProfileOrdersView: View {
    
    @Environment(\.currentUser) private var user
    
    @State private var coupons: [Coupon]?
    @State private var qr: Coupon?
    
    var body: some View {
        
        if let coupons = coupons, coupons.count > 0 {
            
            let layout = [GridItem(.flexible()),
                          GridItem(.flexible())]
            LazyVGrid (columns: layout) {
            
                ForEach(coupons, id: \.self) { coupon in
                    
                    VStack {
                        
                        coupon.reward.image.resizable()
                            .scaledToFit()
                            .padding(.horizontal)
                            
                        Text(coupon.reward.name).bold()
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                        
                        Text("(Tap for QR code)")
                            .font(.system(size: 15, weight: .light, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.themeDark)
                        
                    }
                    .foregroundColor(.themeDark)
                    .bubbleStyle()
                    .sheet(item: $qr) { c in
                        
                        ZStack {
                            
                            Color.white
                                .ignoresSafeArea()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                            VStack {
                                
                                Image(uiImage: UIImage(data: c.QRData) ?? UIImage()).resizable()
                                    .scaledToFit()
                                    .padding(.horizontal)
                                    .padding().padding()
                                
                                Text("Show this to an authorized board member and redeem your reward!")
                                    .foregroundColor(.themeDark).bold()
                                    .font(.body)
                                    .padding(40)
                                
                                    .multilineTextAlignment(.center)
                                
                            }
                            
                        }
                        
                    }
                    .onTapGesture {
                        qr = coupon
                    }
                    
                    .contextMenu(menuItems: {
                        
                        Text(coupon.id)
                        Button("Copy Order ID") {
                            UIPasteboard.general.setValue(coupon.id, forPasteboardType: kUTTypePlainText as String)
                        }
                        
                    })
                    
                }
                
            }
            .padding(.horizontal)
            
        }
        
        else if coupons != nil {
            
            VStack {
                
                Image(systemName: "wand.and.stars")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.themeLight)
                    .padding()
                
                Text("You don't have any coupons yet. Use your points to redeem rewards on the Home page!")
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
                    DatabaseController.getCouponsForUser(email: user.wrappedValue!.email) { documents in
                        coupons = documents
                    }
                }
            
        }
        
    }
    
}

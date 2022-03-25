//
//  OrderScannerView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/29/21.
//

import SwiftUI
import CodeScanner

///Camera view that reads interprets QR codes in the context of Smart Andover's reward database.
///- note: This view uses the [CodeScanner package](https://github.com/twostraws/CodeScanner).
struct AdminScannerView: View {
    
    @State private var isScanning = false
    
    @State private var coupon: Coupon?
    @State private var error: Error?
    
    var body: some View {
        
        VStack {
            
            if let coupon = coupon {
                //Info
                VStack {
                    
                    coupon.reward.image.resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text(coupon.reward.name)
                        .foregroundColor(.themeDark).bold()
                        .font(.title)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                    
                    Text("Owned by " + coupon.buyer)
                        .foregroundColor(.primary)
                        .font(.title)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                }
                .bubbleStyle(padding: 40)
                .padding()
                
            }
            
            //QR Camera button
            Button("Open Scanner") {
                isScanning = true
            }
            
            if coupon != nil {
                //Exchange Button
                AlertButton(label: Text("Exchange"),
                            title: Text("Exchange Coupon?"),
                            message: Text("Once exchanged, this coupon will be removed from records permanently. Make sure the buyer has received their rightfully-owned reward."),
                            primaryButton: .cancel(),
                            secondaryButton: .destructive(Text("Exchange"), action: useCurrentCoupon))
                    .buttonStyle(BarButtonStyle(tint: .red))
                    .padding(.horizontal)
            }
            
            if let error = error {
                Text(error.localizedDescription).foregroundColor(.red)
            }
            
        }
        .sheet(isPresented: $isScanning) {
            QRScanner()
        }
        
    }
    
    func QRScanner () -> some View {
        
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                
                if case let .success(code) = result {
                    DatabaseController.getCoupon(id: code.string) { coupon, error in
                        self.coupon = coupon
                        self.error = error
                        self.isScanning = false
                    }
                }
                
            }
        )
        .ignoresSafeArea()
        
    }
    
    func useCurrentCoupon () {
        
        guard let coupon = coupon else {
            return
        }
        
        DatabaseController.useCoupon(id: coupon.id)
        self.coupon = nil
        
    }
    
    
}

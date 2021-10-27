//
//  SideMenuView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 10/4/21.
//

import SwiftUI

struct SideMenuView: View {
    
    @Environment(\.currentUser) var user
    @Binding var currentPage: Pages
    @Binding var isShowing: Bool
    
    var body: some View {
        
        VStack {
            
            Text("Menu")
                .font(.title.bold())
                .foregroundColor(.themeDark)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Label("\(user.wrappedValue!.firstName) \(user.wrappedValue!.lastName)", systemImage: "person.circle.fill")
                .font(.headline.bold())
                .foregroundColor(.theme)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .onTapGesture {
                    currentPage = .profile
                    isShowing = false
                }
            
            Divider()
            
            ForEach(Pages.allCases, id: \.self) { page in
                
                if (page != .authorized) || (user.wrappedValue?.authority.isAuthorized ?? false) {
                    
                    Button(action: {
                        currentPage = page
                        isShowing = false
                    }, label: {
                        Label(page.title, systemImage: page.systemImageName)
                            .foregroundColor(page == currentPage ? .themeDark : .theme)
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                }
                
            }
            
            Divider()
            
            AlertButton(label: Label("Logout", systemImage: "power") .foregroundColor(.theme),
                        title: Text("Are you sure you want to logout?"),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text("Logout"), action: {
                            isShowing = false
                            currentPage = .home
                            user.wrappedValue = nil
                        }))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Spacer()
            
        }
        .padding()
        
    }
    
}

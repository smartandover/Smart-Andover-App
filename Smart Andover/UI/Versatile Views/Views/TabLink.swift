//
//  TabLink.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 8/14/21.
//

import SwiftUI

///Convenience view to add a label and destination to a TabView. Similar to NavigationLink in the context of a NavigationView.
struct TabLink<Content: View, Icon: View>: View {
    
    @State var tabItem: () -> Icon
    @State var destination: () -> Content
    
    init (tabItem: Icon, destination: Content) {
        self.tabItem = {tabItem}
        self.destination = {destination}
    }
    
    init (@ViewBuilder tabItem: @escaping () -> Icon, @ViewBuilder destination: @escaping () -> Content) {
        self.tabItem = tabItem
        self.destination = destination
    }
    
    init (tabItem: Icon, @ViewBuilder destination: @escaping () -> Content) {
        self.tabItem = {tabItem}
        self.destination = destination
    }
    
    var body: some View {
        
        destination()
            .tabItem {
                tabItem()
                    .padding(.top)
            }
        
    }
    
}

//
//  User.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/5/21.
//

import SwiftUI

private struct DefaultCurrentUserKey: EnvironmentKey {
    static let defaultValue: Binding<User?> = .constant(nil)
}

extension EnvironmentValues {

    var currentUser: Binding<User?> {
        
        get { self[DefaultCurrentUserKey.self] }
        set { self[DefaultCurrentUserKey.self] = newValue }
        
    }

}

extension View {
    
    func currentUser (_ user: Binding<User?>) -> some View {
        environment(\.currentUser, user)
    }
    
}

//
//  NamespaceEnvironment.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 11/29/21.
//

import SwiftUI


private struct WrappedNamespace {
    
    var id: Namespace.ID?
    
}

private struct NamespaceEnvironmentKey: EnvironmentKey {
    
    static let defaultValue: WrappedNamespace = .init(id: nil)
    
}

extension EnvironmentValues {
    
    var namespace: Namespace.ID? {
        
        get { self[NamespaceEnvironmentKey.self].id }
        set { self[NamespaceEnvironmentKey.self] = WrappedNamespace(id: newValue) }
        
    }
    
}

extension View {
    
    func namespace (_ ns: Namespace.ID) -> some View {
        environment(\.namespace, ns)
    }
    
}

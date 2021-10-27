//
//  SmartModel.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/4/21.
//

import SwiftUI

struct SmartModel {
    
    let theme: Color
    let title: String
    let symbol: Image
    let text: String
    
}

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

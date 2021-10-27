//
//  Credentials.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/23/21.
//

import Foundation

class Keychain {
    
    static let server = "www.smartandover.com"
    
    static func saveCredentials (email: String, password: String) {
        
        let password = password.data(using: .utf8)!
        
        var query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrPath as String: email,
            kSecValueData as String: password,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return }
        
    }
    
}

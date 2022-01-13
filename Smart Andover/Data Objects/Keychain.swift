//
//  Credentials.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/23/21.
//

import SwiftUI

//https://developer.apple.com/documentation/security/keychain_services/keychain_items/
class Keychain {
    
    static let server = "https://football-f559a.firebaseio.com"
    
    enum KeychainError: Error {
        case noPassword, unexpectedPasswordData, unhandledError(status: OSStatus)
    }
    
    static func autoSignIn (_ user: Binding<User?>, completion: (() -> Void)? = nil) throws {
        
        guard let credentials = try? retrieveCredentials() else { throw KeychainError.noPassword }
        
        DatabaseController.signIn(email: credentials.email, password: credentials.password) { retrievedUser, error in
            user.wrappedValue = retrievedUser
            completion?()
        }
        
    }
    
    static func saveCredentials (email: String, password: String, completion: (() -> Void)? = nil) throws {
        
        let password = password.data(using: .utf8)!
        
        let query: [String : Any] = [
            kSecAttrServer as String: server,
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        completion?()
        
    }
    
    static func retrieveCredentials () throws -> (email: String, password: String) {
        
        let query: [String: Any] = [
            kSecAttrServer as String: server,
            kSecClass as String: kSecClassInternetPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let item = item as? [String : Any],
              let passwordData = item[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8),
              let email = item[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        return (email: email, password: password)
        
    }
    
    static func updateCredentials (newEmail: String, newPassword: String, completion: (() -> Void)? = nil) throws {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: server
        ]
        
        
        var attributes: [String: Any] = [kSecValueData as String: newPassword.data(using: .utf8)!]
        
        if let current = try? retrieveCredentials(), current.email != newEmail {
            attributes[kSecAttrAccount as String] = newEmail
        }
        
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        completion?()
        
    }
    
}

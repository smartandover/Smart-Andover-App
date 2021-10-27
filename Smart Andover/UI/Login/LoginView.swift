//
//  LoginView.swift
//  Smart Andover
//
//  Created by Chaniel Ezzi on 9/7/21.
//

import SwiftUI

struct LoginView: View {
    
    @Namespace var namespace
    
    private enum Pages {
        case start, login, register
    }
    
    @Binding var user: User?
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var error: Error?
    @State private var shouldStarFields: Bool = false
    @State private var state: Pages = .start
    
    var body: some View {
        
        switch state {
        
        case .start:
            StartView()
            
        case .login:
            LoginView()
            
        case .register:
            RegisterView()
            
        }
        
    }
    
    @ViewBuilder func StartView () -> some View {
        
        VStack {
            
            Button("Login") {
                
                withAnimation {
                    state = .login
                }
                
            }
            .buttonStyle(BarButtonStyle(tint: .theme))
            .matchedGeometryEffect(id: 0, in: namespace)
            
            HStack {
                
                VStack {Divider()}
                
                Text("OR")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                VStack {Divider()}
                
            }
            
            Button("Register") {
                
                withAnimation {
                    state = .register
                }
                
            }
            .buttonStyle(BarButtonStyle(tint: .green))
            .matchedGeometryEffect(id: 1, in: namespace)
            
        }
        .padding()
        
    }
    
    @ViewBuilder func LoginView () -> some View {
        
        VStack (spacing: 10) {
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .requiredField($shouldStarFields)
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .requiredField($shouldStarFields)
            
            Button("Login", action: login)
                .buttonStyle(BarButtonStyle(tint: .theme))
                .matchedGeometryEffect(id: 0, in: namespace)
            
            Button("Back") {
                
                withAnimation {
                    shouldStarFields = false
                    error = nil
                    state = .start
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.theme)
            
            if let error = error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                    .font(.caption)
                    .layoutPriority(1)
            }
            
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        
    }
    
    @ViewBuilder func RegisterView () -> some View {
        
        VStack (spacing: 10) {
            
            TextField("First name", text: $firstName)
                .textContentType(.givenName)
                .requiredField($shouldStarFields)
            
            TextField("Last name", text: $lastName)
                .textContentType(.familyName)
                .requiredField($shouldStarFields)
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .requiredField($shouldStarFields)
            
            SecureField("Password", text: $password)
                .textContentType(.newPassword)
                .requiredField($shouldStarFields)
            
            Button("Register", action: register)
                .buttonStyle(BarButtonStyle(tint: .green))
                .matchedGeometryEffect(id: 1, in: namespace)
            
            Button("Back") {
                
                withAnimation {
                    shouldStarFields = false
                    error = nil
                    state = .start
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.theme)
            
            if let error = error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                    .font(.caption)
                    .layoutPriority(1)
            }
            
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        
    }
    
    func login () {
        
        guard !email.isEmpty && !password.isEmpty else {
            shouldStarFields = true
            return
        }
        
        DatabaseController.signIn(email: email, password: password) { user, error in
            
            withAnimation {
                self.user = user
                self.error = error
            }
            
        }
        
    }
    
    func register () {
        
        guard !email.isEmpty && !password.isEmpty else {
            shouldStarFields = true
            return
        }
        
        DatabaseController.signUp(firstName: firstName, lastName: lastName, email: email, password: password) { user, error in
            
            withAnimation {
                self.user = user
                self.error = error
            }
            
        }
        
    }
    
}

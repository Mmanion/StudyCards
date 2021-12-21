//
//  AuthenticationService.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/21/21.
//

import Foundation
import Firebase

class AuthenticationService: ObservableObject {
    
    @Published var user: User?
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        addListners()
    }
    
    static func signIn() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }
    }
    
    private func addListners() {
        
        if let handle = authenticationStateHandler {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        
        authenticationStateHandler = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
        
    }
    
    
    
    
}

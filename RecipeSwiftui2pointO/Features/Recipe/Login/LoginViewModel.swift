//
//  LoginViewModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import Combine
import Foundation
import FirebaseAuth
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var session: FirebaseSession?
    @Published var emailProxy = InputProxy(type: .email)
    @Published var passwordProxy = InputProxy(type: .password)
    @Published var isLoading: Bool = false
    @Published var isLoggedIn = PassthroughSubject<Bool, Never>()
    
    
    init() {
        emailProxy.value = "vsgaurang@gmail.com"
        passwordProxy.value = "vyas1313"
        
    }
    
    func submit(_ isLogin: Bool)  {
        isLoading = true
        isLogin ? login() : register()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: emailProxy.value, password: passwordProxy.value) { (user, error) in
            self.isLoading = false
            if let error = error {
                print(error.localizedDescription)
            }
            else if let user = user {
                self.isLoggedIn.send(true)
                print(user)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: emailProxy.value, password: passwordProxy.value) { (user, error) in
            self.isLoading = false
            if let error = error {
                print(error.localizedDescription)
            }
            else if let user = user {
                self.isLoggedIn.send(true)
                print(user)
            }
        }
    }
}

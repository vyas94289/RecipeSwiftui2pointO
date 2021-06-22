//
//  EmailProxy.swift
//  ChatSwiftUI
//
//  Created by Gaurang Vyas on 08/02/21.
//

import Combine
import Foundation

class InputProxy: ObservableObject {
   
    var type: TextFieldType
    @Published var value: String = ""
    @Published private(set) var error: String = ""
    @Published private(set) var state: TextFieldState = .normal
    var resigned: (() -> Void)?
    
    var cancellable: AnyCancellable?
    
    init(type: TextFieldType) {
        self.type = type
        cancellable = $value.sink { value in
            self.validate(value: value)
        }
    }
    
    func validate(value: String, showError: Bool = false) {
        switch type {
        case .email:
            validateEmail(value, showError: showError)
        case .password:
            validatePassword(value, showError: showError)
        default:
            break
        }
        
    }
    
    func resign(changed: Bool) {
        if changed {
            self.error = ""
        } else {
            validate(value: value, showError: true)
            resigned?()
        }
    }
    
    func validateEmail(_ value: String, showError: Bool = false) {
        guard !value.isEmpty else {
            state = .normal
            return
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailPred.evaluate(with: value)
        if isValid {
            self.error = ""
            state = .success
        } else {
            if showError {
                error = "Invalid email Address"
            }
            state = .error
        }
    }
    
    func validatePassword(_ value: String, showError: Bool = false) {
        if value.isEmpty {
            state = .normal
        } else if value.count > 5 {
            state = .success
        } else {
            state = .error
        }
    }
}


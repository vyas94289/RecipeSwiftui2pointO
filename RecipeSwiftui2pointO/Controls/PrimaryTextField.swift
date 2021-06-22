//
//  PrimaryTextField.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 08/02/21.
//

import SwiftUI

enum TextFieldType {
    case email
    case password
    case name
    
    var title: String {
        switch self {
        case .email:
            return "Email Address"
        case .password:
            return "Password"
        case .name:
            return "Full Name"
        }
    }
    
    var image: String {
        switch self {
        case .email:
            return "envelope"
        case .password:
            return "lock"
        case .name:
            return "person"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
    
    var autocapitalization: UITextAutocapitalizationType {
        return self == .name ? .words : .none
    }
}

struct PrimaryTextField: View {
    @Binding var proxy: InputProxy
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: proxy.type.image).frame(width: 20)
                ZStack(alignment: .leading) {
                    if proxy.value.isEmpty { Text(proxy.type.title) }
                    TextField(proxy.type.title, text: $proxy.value) { changed in
                        proxy.resign(changed: changed)
                    } onCommit: {
                        print("Commit")
                    }
                    .frame( height: 30)
                    .keyboardType(proxy.type.keyboardType)
                    .autocapitalization(proxy.type.autocapitalization)
                }
            }.accentColor(Color.white)
            Divider()
                .frame(height: 1)
                .background(proxy.state.color)
            if !proxy.error.isEmpty { Text(proxy.error).font(.caption).foregroundColor(Color.red) }
        }.foregroundColor(Color.white)
    }
}

struct PrimarySecureTextField: View {
    @Binding var proxy: InputProxy
    @State private var showPassword: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: proxy.type.image)
                ZStack(alignment: .leading) {
                    if proxy.value.isEmpty { Text(proxy.type.title) }
                    if showPassword {
                        TextField("", text: $proxy.value) { changed in
                            proxy.resign(changed: changed)
                        } onCommit: {
                            print("Commit")
                        }
                        .frame( height: 30)
                        .keyboardType(proxy.type.keyboardType)
                        .autocapitalization(proxy.type.autocapitalization)
                    } else {
                        SecureField("", text:  $proxy.value) {
                            proxy.resign(changed: true)
                        }
                        .frame( height: 30)
                        .keyboardType(proxy.type.keyboardType)
                        .autocapitalization(proxy.type.autocapitalization)
                    }
                }
                Button(action: {
                    showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                })
            }.accentColor(Color.white)
            Divider()
                .frame(height: 1)
                .background(proxy.state.color)
            if !proxy.error.isEmpty { Text(proxy.error).font(.caption).foregroundColor(Color.red) }
        }.foregroundColor(Color.white)
    }
}


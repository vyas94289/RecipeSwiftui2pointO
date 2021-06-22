//
//  LaunchScreenView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import SwiftUI

enum LaunchScreenActiveSheet: Identifiable {
   case login, signUp
    var id: Int {
        hashValue
    }
}

struct LaunchScreenView: View {
    
    @StateObject var session: FirebaseSession
    @State private var activeSheet: LaunchScreenActiveSheet?

    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Image(Images.logo)
                    Text("Cooking Done The Easy Way")
                        .font(.caption)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.top, geometry.size.height / 3)
                VStack(spacing: 30) {
                    Spacer()
                    Button("Register") {
                        self.activeSheet = .signUp
                    }.orangeButtonStyle()
                    Button("Login") {
                        self.activeSheet = .login
                    }.foregroundColor(Color.white)
                }.padding( 30)
            }.frame(width: geometry.size.width)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(BackgroundImageView(size: .zero))
        .ignoresSafeArea(.container)
        .fullScreenCover(item: $activeSheet) { item in
            switch item {
            case .login:
                LoginView(isFromLoggin: true, session: session)
            case .signUp:
                LoginView(isFromLoggin: false, session: session)
            }
        }
    }
}


//
//  LoginView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 06/02/21.
//

import SwiftUI
import Combine

struct LoginView: View {
    var isFromLoggin: Bool
    var title: String {
        isFromLoggin ? "Sign In" : "Register"
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = LoginViewModel()
    var cancellable: AnyCancellable?
    
    init(isFromLoggin: Bool, session: FirebaseSession) {
        self.isFromLoggin = isFromLoggin
        cancellable = self.viewModel.isLoggedIn.sink { (isLoggedIn) in
            session.isLoggedIn.send(isLoggedIn)
        }
    }
  
    var body: some View {
        GeometryReader() { geometry in
            ZStack(alignment: .topLeading) {
                ScrollView(.vertical) {
                    VStack( spacing: 50) {
                        Image(Images.logo)
                        Text(title)
                            .font(Font.headline.weight(.bold))
                            .foregroundColor(Color.white)
                        VStack(spacing: 30) {
                            PrimaryTextField(proxy: $viewModel.emailProxy)
                            PrimarySecureTextField(proxy: $viewModel.passwordProxy)
                        }
                        LoadingButton(isLoading: $viewModel.isLoading, title: title) {
                            viewModel.submit(isFromLoggin)
                        }
                    }
                    .padding(.horizontal, 30)
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left").padding()
                })
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 0, trailing: 0))
                .foregroundColor(Color.white)
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(BackgroundImageView(size: .zero))
        .ignoresSafeArea(.container)
    }
    
}

//
//  ProfileView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/02/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var isShowPhotoLibrary = false
    @EnvironmentObject var session: FirebaseSession
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                profileImageView
                contentView
                Spacer()
            }
            .ignoresSafeArea()
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarHidden(true)
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.image)
            }
        }
        .onAppear() {
            viewModel.session = session
        }
    }
    
    func buttonTapped() {
        isShowPhotoLibrary.toggle()
    }
    
    var profileImageView: some View {
        ZStack(alignment: .bottom) {
            ArcShape()
                .foregroundColor(.primaryClr)
            ZStack(alignment: .bottomTrailing) {
                if viewModel.profileImage == nil {
                    Image(uiImage: viewModel.image ?? Images.getSystem(name: "person.circle", of: 80))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else {
                    URLImage(urlString: viewModel.profileImage,
                             placeholder: Image(uiImage: Images.getSystem(name: "person.circle", of: 80))
                                .resizable()
                                .eraseToAnyView())
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
                Button(action: buttonTapped, label: {
                    Image(systemName: "camera").frame(width: 30, height: 30)
                }).background(Color.white).clipShape(Circle())
            }.padding(.bottom, 20)
        
            if viewModel.isUploading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(width: 80, height: 80, alignment: .center)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
                    .padding(.bottom, 20)
            }
        }.frame(width: UIScreen.main.bounds.width, height: 150)
    }
    
    var contentView: some View {
        VStack {
            PrimaryTextField(proxy: $viewModel.username)
            Button("Logout") {
                session.logOut()
            }.orangeButtonStyle()
        }.padding(.horizontal, 30)
    }
}

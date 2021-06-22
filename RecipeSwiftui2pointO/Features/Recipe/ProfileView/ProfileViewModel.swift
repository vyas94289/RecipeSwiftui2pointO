//
//  ProfileViewModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/02/21.
//

import Combine
import UIKit

class ProfileViewModel: ObservableObject {
    var session: FirebaseSession? {
        didSet {
            observeUser()
        }
    }
    @Published var profileImage: String?
    @Published var isUploading: Bool = false
    @Published var image: UIImage? {
        didSet {
            uploadImage()
        }
    }
    
    @Published var username = InputProxy(type: .name)
    var changeSink: AnyCancellable?
    
    init() {
        username.resigned = {
            self.changeValue(key: .displayName, value: self.username.value)
        }
    }
    
    func observeUser() {
        changeSink = session?.session?.objectWillChange.sink { void in
            guard let user = self.session?.session else {
                return
            }
            self.profileImage = user.profileImage
            self.username.value = user.displayName ?? ""
        }
    }
    
    func uploadImage() {
        guard let image = self.image?.compressTo(0.5), let session = self.session else {
            return
        }
        isUploading = true
        session.uploadProfile(image: image, completion: { (url) in
            self.isUploading = false
            guard let urlString = url?.absoluteString else {
                return
            }
            session.setProfileInfo(key: .profileImage, value: urlString)
        })
    }
    
    func changeValue(key: UserKeys, value: String) {
        session?.setProfileInfo(key: key, value: value)
    }
}

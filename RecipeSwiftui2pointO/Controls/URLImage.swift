//
//  URLImage.swift
//  ChatSwiftUI
//
//  Created by Gaurang Vyas on 20/01/21.
//

import SwiftUI
import Kingfisher

struct URLImage: SwiftUI.View {
    var urlString: String?
    let placeholder: AnyView?
    var body: some SwiftUI.View {
        KFImage(URL(string: urlString ?? ""))
            .resizable()
            .placeholder {
                if placeholder == nil {
                    Rectangle()
                } else {
                    placeholder
                }
            }
            .cancelOnDisappear(true)
            
    }
}



//
//  RecipeContentView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 26/04/21.
//

import SwiftUI

struct RecipeContentView: View {
    @StateObject var session = FirebaseSession()

    var body: some View {
        if session.isLoggedIn.value {
            TabBarView().environmentObject(session)
        } else {
            LaunchScreenView(session: session)
        }
    }
}

struct RecipeContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeContentView()
    }
}

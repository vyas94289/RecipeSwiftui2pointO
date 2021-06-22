//
//  TabBarView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/02/21.
//

import SwiftUI
import FirebaseDatabase

struct TabBarView: View {
    @State var tabSelection = 0
    @EnvironmentObject var session: FirebaseSession
    @State var dismiss = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeScreenView(dismiss: $dismiss)
               .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
                .environmentObject(session)
            AddRecipeView(selectedTab: $tabSelection, session: session)
                .tabItem {
                    Image(systemName: "plus.circle")
                   
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag(2)
                .environmentObject(session)
        }
        .onChange(of: dismiss) { value in
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
}


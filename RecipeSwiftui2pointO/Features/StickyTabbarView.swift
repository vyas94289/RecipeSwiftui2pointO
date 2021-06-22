//
//  StickyTabbarView.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 21/04/21.
//

import SwiftUI

struct StickyTabbarView: View {
    let tabs: [String] = ["Trending", "New", "Favorite"]
    @State var rows: Int = 10
    @State var selectedTab: Int = 0
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5, pinnedViews: [.sectionHeaders]) {
                Image(Images.background)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200, alignment: .top)
                    .clipped().listRowInsets(EdgeInsets())
                Section(header: SegmentView(tabs: tabs, selectedTab: $selectedTab).padding( 10)) {
                    ForEach(0..<rows, id: \.self) {
                        Text("Index \($0)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .clipShape(Capsule())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                    
                }
                Spacer()
            }
        }
        .navigationBarTitle("Sticky Header", displayMode: .inline)
        .onChange(of: selectedTab, perform: { index in
            withAnimation {
                rows = (selectedTab + 1) * 10
            }
            
        })

    }
}

struct SegmentView: View {
    let tabs: [String]
    @Binding var selectedTab: Int
    @State var tabOffset: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(.systemGray3))
                    .offset(x: tabOffset)
                    .frame(width: proxy.size.width / CGFloat(tabs.count))
                HStack(spacing: 0) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Button(tabs[index]) {
                            withAnimation {
                                tabOffset = (proxy.size.width / CGFloat(tabs.count)) * CGFloat(index)
                            }
                            selectedTab = index
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.primary)
                        .contentShape(Rectangle())
                    }
                }
            }
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(Blur())
        .clipShape(Capsule())
    }
}

struct StickyTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        StickyTabbarView()
    }
}

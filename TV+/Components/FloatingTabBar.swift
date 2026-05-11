//
//  FloatingTabBar.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI

struct FloatingBottomBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        HStack {
            tabItem(icon: "house.fill", tab: .home)
            tabItem(icon: "magnifyingglass", tab: .search)
            tabItem(icon: "bookmark.fill", tab: .watchList)
        }.padding(.vertical, 14)
            .padding(.horizontal, 10)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.2),radius: 10, y:5)
    }
    
    func tabItem(icon:String, tab:Tab) -> some View {
        Image(systemName: icon)
            .font(.system(size: 30, weight: .semibold))
            .foregroundColor(selectedTab == tab ? .white : .gray.opacity(0.4))
            .onTapGesture {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                }
            }
    }
}

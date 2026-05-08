//
//  GomeScreen.swift
//  TV+
//
//  Created by neo on 5/8/26.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        contentView
        
        VStack {
            Spacer()
            FloatingBottomBar(selectedTab: $selectedTab)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch selectedTab {
        case .home:
            Text("Home")
        case .watchList:
            Text("Watchlist")
        case .search:
            Text("Search")

        }
    }
}


struct FloatingBottomBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        HStack {
            tabItem(icon: "house.fill", tab: .home)
            tabItem(icon: "magnifyingglass", tab: .search)
            tabItem(icon: "bookmark.fill", tab: .watchList)
        }.padding(.vertical, 14)
            .padding(.horizontal, 28)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.2),radius: 10, y:5)
    }
    
    func tabItem(icon:String, tab:Tab) -> some View {
        Image(systemName: icon)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(selectedTab == tab ? .white : .gray.opacity(0.4))
            .onTapGesture {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                }
            }
    }
}

#Preview {
    HomeScreen()
}

enum Tab {
    case home, watchList, search
}

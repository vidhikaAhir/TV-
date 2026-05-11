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
        ZStack(alignment: .bottom) {
            contentView
            FloatingBottomBar(selectedTab: $selectedTab)
                .padding(.horizontal, 24)
        }.background(Color.black)
    }
    
    @ViewBuilder
    var contentView: some View {
        switch selectedTab {
        case .home:
            MoviesScreen(viewModel: MoviesViewModel())
        case .watchList:
            WatchListScreen()
        case .search:
            SearchScreen()
        }
    }
}

#Preview {
    HomeScreen()
}

enum Tab {
    case home, watchList, search
}

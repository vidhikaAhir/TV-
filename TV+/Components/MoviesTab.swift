//
//  MoviesTab.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI

struct MoviesTab: View {
    @State private var selectedTab: TopTab = .first
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Content
            TabView(selection: $selectedTab) {
                ListView(selectedTab: selectedTab).tag(TopTab.first)
                ListView(selectedTab: selectedTab).tag(TopTab.second)
                ListView(selectedTab: selectedTab).tag(TopTab.third)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.top, 50)
            FloatingTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 20)
                .padding(.top, 10)
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    MoviesTab()
}


enum TopTab: Int, CaseIterable {
    case first, second, third
    
    var title: String {
        switch self {
        case .first: return "Tab 1"
        case .second: return "Tab 2"
        case .third: return "Tab 3"
        }
    }
}

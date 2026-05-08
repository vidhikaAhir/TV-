//
//  FloatingTabBar.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI

struct FloatingTabBar: View {
    
    @Binding var selectedTab: TopTab
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(TopTab.allCases, id: \.self) { tab in
                Text(tab.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(selectedTab == tab ? .white : .black)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        selectedTab == tab
                        ? Color.black
                        : Color.clear
                    )
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedTab = tab
                        }
                    }
            }
        }
        .padding(6)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
        )
    }
}

struct ListView: View {
    
    let selectedTab: TopTab
    
    var body: some View {
        switch selectedTab {
        case .first:
            List(0..<20) { i in Text("First List \(i)") }
            
        case .second:
            List(0..<20) { i in Text("Second List \(i)") }
            
        case .third:
            List(0..<20) { i in Text("Third List \(i)") }
        }
    }
}
//#Preview {
//    FloatingTabBar(selectedTab: <#Binding<TopTab>#>)
//}

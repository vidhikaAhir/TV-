//
//  ContentView.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var appData = AppData()
    
    var body: some View {
        MoviesScreen(viewModel: MoviesViewModel())
            .environmentObject(appData)
            .task {
                await loadGenre()
            }
    }
    
    func loadGenre() async {
        do {
            let helper = APIHelper()
            let response : GenreList.response = try await helper.fetchRequests(request:GenreList())
            print(response)
            await MainActor.run {
                self.appData.genre = response
            }
        } catch {
            print("Failed to get movies \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}

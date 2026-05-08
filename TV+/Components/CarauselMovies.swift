//
//  CarauselMovies.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI
import Combine

struct CarauselMovies: View {
    
    @State private var movies : Movie?
    @State private var currentIndex = 0
    var geo : (GeometryProxy)
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
            TabView(selection: $currentIndex) {
                ForEach((movies?.results ?? []).enumerated(), id: \.offset) { index, movie in
                    BannerCard(movieDetails: movie)
                        .frame(height: geo.size.height * 2.6/3)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: geo.size.height * 2.6/3, alignment: .top)
        .background(Color.red)
        .onReceive(timer) { _ in
            let count = movies?.results.count ?? 0
            guard count > 0 else { return }
            
            withAnimation(.easeInOut(duration: 0.4)) {
                currentIndex = (currentIndex + 1) % count
            }
        }
        .task {
            do {
                let network = APIHelper()
                let request = UpcomingMoviesList()
                movies = try await network.fetchRequests(request: request)
                currentIndex = 0
            } catch {
                print("failed to fetch \(error.localizedDescription)")
            }
        }
    }
}


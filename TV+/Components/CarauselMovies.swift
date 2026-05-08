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
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            let bannerHeight = geo.size.height * 2.5/3
            
            TabView(selection: $currentIndex) {
                ForEach((movies?.results ?? []).enumerated(), id: \.offset) { index, movie in
                    BannerCard(movieDetails: movie)
                        .frame(width: geo.size.width, height: bannerHeight)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .frame(width: geo.size.width, height: bannerHeight, alignment: .top)
        }
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

#Preview {
    CarauselMovies()
}


struct BannerCard : View {
    
    var movieDetails: Result

    var loadImages : LoadImages {
        LoadImages(url: movieDetails.posterPath)
            
    }
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            CachedImageView(request: loadImages, contentMode: .fill)
            LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
            Text(movieDetails.originalTitle)
                .font(.system(size: 35, weight: .bold))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .shadow(color: .black.opacity(0.8), radius: 6)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            Text(movieDetails.originalTitle)

        })
    }
}

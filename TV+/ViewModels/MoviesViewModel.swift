//
//  MoviesViewModel.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import Combine
import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
    
    @Published var trendingMovies : [MovieResult] = []
    @Published var topMovies : [MovieResult] = []
    @Published var popularMovies : [MovieResult] = []
    @Published var topShows : [MovieResult] = []
    
    var trendingMoviesPage = 0
    var topMoviesPage = 0
    var popularMoviesPage = 0
    var topShowsPage = 0

    @Published var search = ""

    func fetchMovies(listType: ListType?) async {
        
        await withTaskGroup(of: Result<ListData, Error>.self) { group in
            let network = APIHelper()
            if (listType == nil || listType == .trending) {
                self.trendingMoviesPage += 1
                group.addTask {
                    do {
                        let response: Movie = try await network.fetchRequests(
                            request: TrendingMoviesList(url: "\(self.trendingMoviesPage)")
                        )
                        return .success(.trending(response))
                    } catch {
                        return .failure(error)
                    }
                }
            }
            
            if (listType == nil || listType == .topMovies) {
                self.topMoviesPage += 1
                group.addTask {
                    do {
                        let response: Movie = try await network.fetchRequests(
                            request: TopMoviesList(url: "\(self.topMoviesPage)")
                        )
                        return .success(.topMovies(response))
                    } catch {
                        return .failure(error)
                    }
                }
            }
            
            if (listType == nil || listType == .popular) {
                self.popularMoviesPage += 1
                group.addTask {
                    do {
                        let response: Movie = try await network.fetchRequests(
                            request: PopularMoviesList(url: "\(self.popularMoviesPage)")
                        )
                        return .success(.popular(response))
                    } catch {
                        return .failure(error)
                    }
                }
            }
            
            if (listType == nil || listType == .topShows) {
                self.topShowsPage += 1
                group.addTask {
                    do {
                        let response: Movie = try await network.fetchRequests(
                            request: TopShowsList(url: "\(self.topShowsPage)")
                        )
                        
                        return .success(.topShows(response))
                        
                    } catch {
                        return .failure(error)
                    }
                }
            }
            
            for await result in group {
                switch result {
                case .success(let data):
                    
                    switch data {
                    case .trending(let movies):
                        trendingMovies.append(contentsOf: movies.results)
                    case .topMovies(let movies):
                        topMovies.append(contentsOf: movies.results)
                    case .popular(let movies):
                        popularMovies.append(contentsOf: movies.results)
                    case .topShows(let movies):
                        topShows.append(contentsOf: movies.results)
                    }
                    
                case .failure(let error):
                    print("API failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
}
enum ListType {
case trending
case topMovies
case popular
case topShows

}

enum ListData {
    case trending(Movie)
    case topMovies(Movie)
    case popular(Movie)
    case topShows(Movie)
}

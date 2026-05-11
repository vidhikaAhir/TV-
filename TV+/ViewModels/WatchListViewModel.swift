//
//  WatchListViewModel.swift
//  TV+
//
//  Created by neo on 5/11/26.
//

import SwiftUI
import Combine
import SwiftData

@MainActor
class WatchListViewModel :ObservableObject {
    
    @Published var results: [MovieResult] = []

    func fetchBookmarkedMovies(context: ModelContext) {
        let descriptor = FetchDescriptor<MovieResultEntity>()
        do {
            let entities = try context.fetch(descriptor)
            let results = entities.map { $0.toMovieResult() }
            self.results = results
            print("watchlist \(results)")
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    func toggleBookmark(movie: MovieResult, context: ModelContext) {
        
        guard let movieID = movie.id else { return }
        
        let descriptor = FetchDescriptor<MovieResultEntity>(
            predicate: #Predicate { $0.id == movieID }
        )
        for index in results.indices {
            if results[index].id == movie.id {
                results[index].isBookmarked = !(results[index].isBookmarked ?? false)
            }
        }
        do {
            let existing = try context.fetch(descriptor)
            if let entity = existing.first {
                context.delete(entity)
            } else {
                let entity = MovieResultEntity(from: movie)
                context.insert(entity)
            }
            try context.save()
        } catch {
            print("Toggle failed: \(error)")
        }
    }
    
}

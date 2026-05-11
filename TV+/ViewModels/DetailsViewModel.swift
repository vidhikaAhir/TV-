//
//  DetailsViewModel.swift
//  TV+
//
//  Created by neo on 5/11/26.
//
import SwiftUI
import SwiftData
import Combine

@MainActor
class DetailsViewModel: ObservableObject {
    
    @Published var isBookMarked = false
    
    func isMovieBookmarked(movieID: Int, context: ModelContext) {
        let descriptor = FetchDescriptor<MovieResultEntity>(
            predicate: #Predicate { $0.id == movieID }
        )
        do {
            let result = try context.fetch(descriptor)
            isBookMarked = !result.isEmpty
        } catch {
            print("Fetch failed: \(error)")
            isBookMarked = false
        }
    }
    
    func toggleBookmark(movie: MovieResult, context: ModelContext) {
        
        guard let movieID = movie.id else { return }
        
        let descriptor = FetchDescriptor<MovieResultEntity>(
            predicate: #Predicate { $0.id == movieID }
        )
        
        do {
            let existing = try context.fetch(descriptor)
            if let entity = existing.first {
                context.delete(entity)
                isBookMarked = false
            } else {
                let entity = MovieResultEntity(from: movie)
                isBookMarked = true
                context.insert(entity)
            }
            try context.save()
        } catch {
            print("Toggle failed: \(error)")
        }
    }
    
    
    func getGenre(genre: [GenreElement], movie: MovieResult) -> [String] {
        let genreIDS = movie.genreIDS
        
        let filtered = genre
            .filter {(genreIDS ?? []).contains($0.id)}
            .map{$0.name}
        
        return filtered
    }
    
    func convertValue(_ value: Double) -> Int {
        return Int(value * 10)
    }
    
    
}

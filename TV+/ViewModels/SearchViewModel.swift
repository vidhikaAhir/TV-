//
//  SearchViewModel.swift
//  TV+
//
//  Created by Vidhika Ahir on 10/05/26.
//

import SwiftUI
import Combine
import SwiftData

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var results: [MovieResult] = []
    @Published var bookmarked: [MovieResult] = []
    @Published var isLoading = false
    @Published var searchText = ""
    
    func search(query: String) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            results = []
            return
        }
        
        do {
            isLoading = true
            let network = APIHelper()
            let request = SearchMulti(url: query)
            let response: Movie =
            try await network.fetchRequests(request: request)
            self.results = response.results
            
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func bookmark(movies: MovieResult, context: ModelContext) {
        let isBookMarked = bookmarked.contains(where: {$0.id == movies.id })
        for index in results.indices {
            if results[index].id == movies.id {
                results[index].isBookmarked = !(results[index].isBookmarked ?? false)
            }
        }
        if (isBookMarked) {
            bookmarked.removeAll { $0.id == movies.id }
            deleteMovie(movieID: movies.id ?? 0, context: context)
        } else {
            self.bookmarked.append(movies)
            saveMovies(movies, context: context)
        }
    }
    
    func saveMovies(_ movie: MovieResult, context: ModelContext) {
        let entity = MovieResultEntity(from: movie)
        context.insert(entity)
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func deleteMovie(movieID: Int, context: ModelContext) {
        let descriptor = FetchDescriptor<MovieResultEntity>(
            predicate: #Predicate { $0.id == movieID }
        )
        do {
            let entities = try context.fetch(descriptor)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        } catch {
            print("Failed to delete: \(error)")
        }
    }
}

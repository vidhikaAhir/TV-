//
//  TV_App.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI
import SwiftData

@main
struct TV_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MovieResultEntity.self)
    }
}

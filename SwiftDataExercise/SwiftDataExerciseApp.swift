//
//  SwiftDataExerciseApp.swift
//  SwiftDataExercise
//
//  Created by Sayalee Pote on 9/5/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExerciseApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Book.self, Friend.self, LoanRecord.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}

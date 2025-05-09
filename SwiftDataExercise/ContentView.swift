//
//  ContentView.swift
//  SwiftDataExercise
//
//  Created by Sayalee Pote on 9/5/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            BooksView()
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
            FriendsView()
                .tabItem {
                    Label("Friends", systemImage: "person.2")
                }
            
            LoanRecordsView()
                .tabItem {
                    Label("Loans", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}

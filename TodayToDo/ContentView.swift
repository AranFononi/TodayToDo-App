//
//  ContentView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
            }//Navigation Stack
            .navigationTitle(Text("Today To Do"))
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty", systemImage: "heart.circle", description: Text("Add some tasks to the list!"))
                }
            }
        }
    }
}
    
    #Preview {
        ContentView()
            .modelContainer(for: Item.self, inMemory: true)
    }

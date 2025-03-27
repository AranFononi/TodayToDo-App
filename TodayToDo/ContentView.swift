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
                        .font(.title3.weight(.medium))
                        .padding(.vertical, 6)
                        .foregroundStyle(item.isCompleted == false ? Color.primary : Color.accentColor)
                        .italic(item.isCompleted)
                        .strikethrough(item.isCompleted)
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
    
#Preview("Sample Data") {
    
    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    
    container.mainContext.insert(Item(title: "Develope iOS App", isCompleted: false))
    container.mainContext.insert(Item(title: "Design iOS App", isCompleted: false))
    container.mainContext.insert(Item(title: "Morning Workout", isCompleted: true))
    container.mainContext.insert(Item(title: "Wakeup early", isCompleted: true))
        
    
    return ContentView()
        .modelContainer(container)
        
}

#Preview("Empty") {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

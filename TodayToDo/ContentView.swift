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
    @State private var newItemTitle: String = ""
    
    
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
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(item)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button("Done", systemImage: item.isCompleted == false ? "checkmark.circle" : "x.circle") {
                                item.isCompleted.toggle()
                            }
                            .tint(item.isCompleted == false ? .green : .accentColor)
                        }
                }
            }//Navigation Stack
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Today To Do")
                            .font(.largeTitle.bold())
                        
                        Spacer()
                        
                        SettingButtonView()
                            .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 4)
                    }
                    .padding(.top, 70)
                    .padding(.horizontal)
                }
            }// Toolbar
            .safeAreaInset(edge: .bottom) {
                VStack {
                    TextField("",text: $newItemTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        let newItem = Item(title: newItemTitle, isCompleted: false)
                        modelContext.insert(newItem)
                    } label: {
                        Text("Add")
                    }
                }
                .padding()
            }
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

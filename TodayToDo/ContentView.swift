//
//  ContentView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var newItemTitle: String = ""
    @FocusState private var isFocused: Bool
    @State var alternateColors = AlternateColors.colors[ContentView.selectedColor]!
    @State static var selectedColor: String = "brown"
    
    let buttonTip = ButtonTip()
    
    init() {
        try? Tips.configure()
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                alternateColors.background
                    .ignoresSafeArea()
                
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .font(.title3.weight(.medium))
                        .padding(.vertical, 6)
                        .foregroundStyle(item.isCompleted == false ? alternateColors.backgroundInvert : alternateColors.listInvert)
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
                        .onTapGesture(perform: {
                            item.isCompleted.toggle()
                        })
                        .swipeActions(edge: .leading) {
                            Button("Done", systemImage: item.isCompleted == false ? "checkmark.circle" : "x.circle") {
                                item.isCompleted.toggle()
                            }
                            .tint(item.isCompleted == false ? .green : .accentColor)
                            
                        }
                        .listRowBackground(alternateColors.list)
                    
                }
                
                
            }//Navigation Stack
            .scrollContentBackground(.hidden)
            .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                
            
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Today To Do")
                            .font(.largeTitle.bold())
                            .foregroundStyle(alternateColors.backgroundInvert)
                            .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                        
                        Spacer()
                        
                        SettingButtonView()
                            .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                            .popoverTip(buttonTip)
                    }
                    .padding(.top, 70)
                    .padding(.horizontal)
                }
            }// Toolbar
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty", systemImage: "heart.circle", description: Text("Add some tasks to the list!"))
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    TextField("",text: $newItemTitle)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .stroke(.white.opacity(0.3), lineWidth: 3)
                            .background(alternateColors.list)
                            .clipShape(RoundedRectangle(cornerRadius: 12)))
                        .font(.title2.weight(.light))
                        .focused($isFocused)
                        .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                    
                    Button {
                        if newItemTitle.isEmpty { return }
                        let newItem = Item(title: newItemTitle, isCompleted: false)
                        modelContext.insert(newItem)
                        newItemTitle = ""
                        isFocused = false
                    } label: {
                        Text("Add")
                            .font(.title2.weight(.medium))
                            .frame(maxWidth: 150)
                            .foregroundStyle(alternateColors.list)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.extraLarge)
                    .tint(alternateColors.listInvert)
                    .padding(.top, 9)
                    .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                }
                .padding()
            }
            
            
        }
        } // Navigation Stack
        
        
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

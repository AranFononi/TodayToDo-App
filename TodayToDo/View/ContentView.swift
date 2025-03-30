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
    @EnvironmentObject private var colorManager: ColorManager
    @State private var isShowingSheet: Bool = false
    @StateObject private var colorSchemeManager = ColorSchemeManager.shared
    //@StateObject private var colorManager = ColorManager.shared
    
    let buttonTip = ButtonTip()
    
    init() {
        try? Tips.configure()
    }
    
    var body: some View {
        @State var alternateColors = AlternateColors.colors[colorManager.selectedColor]!
        
        
        ZStack {
            alternateColors.background
                .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .center) {
                    Text("Today To Do")
                        .font(.largeTitle.bold())
                        .foregroundStyle(alternateColors.backgroundInvert)
                        .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                    
                    Spacer()
                    Button {
                        isShowingSheet.toggle()
                    } label: {
                        SettingButtonView()
                            .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                            .popoverTip(buttonTip)
                            .frame(width: 40, height: 40)
                    }
                    .sheet(isPresented: $isShowingSheet) {
                        SettingsView()
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium, .large])
                            .environment(\.colorScheme, colorSchemeManager.getPreferredColorScheme())
                            .environmentObject(colorSchemeManager)
                            .environmentObject(colorManager)
                    }
                }
                .frame(minHeight: 30)
                .background(alternateColors.background.blur(radius: 5).opacity(0.2))
                .padding(.top, 30)
                .padding(.horizontal, 30)
                
                // Toolbar
                ZStack {
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
                        
                        
                    }//List
                    .scrollContentBackground(.hidden)
                    .shadow(color: .white.opacity(0.08), radius: 20, x: 0, y: 6)
                    
                    
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
            }
        
            
            
            
        }
    } // Navigation Stack
    
    
}






#Preview("Sample Data") {
    
    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    
    container.mainContext.insert(Item(title: "Develope iOS App", isCompleted: false))
    container.mainContext.insert(Item(title: "Design iOS App", isCompleted: false))
    container.mainContext.insert(Item(title: "Morning Workout", isCompleted: true))
    container.mainContext.insert(Item(title: "Wakeup early", isCompleted: true))
    
    
    return ContentView()
        .modelContainer(container)
        .environmentObject(ColorSchemeManager.shared)
        .environmentObject(ColorManager.shared)
    
}

#Preview("Empty") {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(ColorSchemeManager.shared)
        .environmentObject(ColorManager.shared)
    
}

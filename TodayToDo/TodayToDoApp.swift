//
//  TodayToDoApp.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI
import SwiftData

@main
struct TodayToDoApp: App {
    @StateObject private var colorSchemeManager = ColorSchemeManager.shared
    @StateObject private var colorManager = ColorManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
                .environment(\.colorScheme, colorSchemeManager.getPreferredColorScheme())
                .environmentObject(colorSchemeManager)
                .environmentObject(colorManager)
        }
    }
}

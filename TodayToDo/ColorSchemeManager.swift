//
//  ColorSchemeManager.swift
//  TodayToDo
//
//  Created by Aran Fononi on 29/3/25.
//

import SwiftUI

class ColorSchemeManager: ObservableObject {
    @Published var selectedColorScheme: String {
        didSet {
            UserDefaults.standard.set(selectedColorScheme, forKey: "selectedColorScheme")
        }
    }

    func getPreferredColorScheme() -> ColorScheme {
        if selectedColorScheme == "light" {
            return .light
        } else {
            return .dark
        }
    }

    static let shared = ColorSchemeManager()

    private init() {
        self.selectedColorScheme = UserDefaults.standard.string(forKey: "selectedColorScheme") ?? "system"
    }
}

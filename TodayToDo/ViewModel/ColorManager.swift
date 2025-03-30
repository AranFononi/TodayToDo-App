//
//  ColorManager.swift
//  TodayToDo
//
//  Created by Aran Fononi on 29/3/25.
//
import SwiftUI

class ColorManager: ObservableObject {
    @Published var selectedColor: String {
        didSet {
            UserDefaults.standard.set(selectedColor, forKey: "selectedColor")
        }
    }

    static let shared = ColorManager()

    private init() {
        self.selectedColor = UserDefaults.standard.string(forKey: "selectedColor") ?? "gray"
    }
}

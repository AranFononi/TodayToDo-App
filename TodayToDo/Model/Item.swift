//
//  Item.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import Foundation
import SwiftData

@Model
class Item {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

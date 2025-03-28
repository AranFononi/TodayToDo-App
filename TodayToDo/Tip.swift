//
//  Tip.swift
//  TodayToDo
//
//  Created by Aran Fononi on 28/3/25.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    var title: Text = Text("Settings")
    var message: Text? = Text("Use this button to customize the app")
    var image: Image? = Image(systemName: "info.circle")
}

//
//  ColorModel.swift
//  TodayToDo
//
//  Created by Aran Fononi on 29/3/25.
//

import SwiftUI

struct ColorVariant {
    let background: Color
    let list: Color
    let backgroundInvert: Color
    let listInvert: Color
}

struct AlternateColors {
    static let colors: [String: ColorVariant] = [
        "blue": ColorVariant(background: .blueBackground, list: .blueList, backgroundInvert: .blueBackgroundInvert, listInvert: .blueListInvert),
        "pink": ColorVariant(background: .pinkBackground, list: .pinkList, backgroundInvert: .pinkBackgroundInvert, listInvert: .pinkListInvert),
        "green": ColorVariant(background: .greenBackground, list: .greenList, backgroundInvert: .greenBackgroundInvert, listInvert: .greenListInvert),
        "gray": ColorVariant(background: .grayBackground, list: .grayList, backgroundInvert: .grayBackgroundInvert, listInvert: .grayListInvert),
        "brown": ColorVariant(background: .brownBackground, list: .brownList, backgroundInvert: .brownBackgroundInvert, listInvert: .brownListInvert)
        
    ]
}



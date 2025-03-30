//
//  SettingButtonView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI

struct SettingButtonView: View {
    @EnvironmentObject private var colorManager: ColorManager

    private var alternateColors: ColorVariant {
            AlternateColors.colors[colorManager.selectedColor] ?? ColorVariant(
                background: .gray, list: .gray, backgroundInvert: .white, listInvert: .black
            )
        }
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(alternateColors.backgroundInvert)
                .clipShape(.circle)
                

            Image(systemName: "gear")
                .font(.title3.weight(.bold))
                .foregroundColor(alternateColors.background)
                
        }
    }
}

#Preview {
    SettingButtonView()
}

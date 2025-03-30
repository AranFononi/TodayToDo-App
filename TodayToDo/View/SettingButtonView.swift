//
//  SettingButtonView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI

struct SettingButtonView: View {
    @EnvironmentObject private var colorManager: ColorManager

    var body: some View {
        @State var alternateColors = AlternateColors.colors[colorManager.selectedColor]!
        
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

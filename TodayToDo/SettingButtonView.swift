//
//  SettingButtonView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI

struct SettingButtonView: View {
    
    @State var alternateColors = AlternateColors.colors[ContentView.selectedColor]!

    var body: some View {
        ZStack {
            Circle()
                .fill(alternateColors.backgroundInvert)
                .clipShape(.circle)
            
            Button {
                //open settings
                print("Open Settings")
            } label: {
                Image(systemName: "gear")
                    .font(.title3.weight(.bold))
                    .foregroundColor(AlternateColors.colors[ContentView.selectedColor]!.background)

                    
            }
                
        }
    }
}

#Preview {
    SettingButtonView()
}

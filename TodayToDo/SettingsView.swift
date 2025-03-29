//
//  SettingsView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 29/3/25.
//

import SwiftUI

struct SettingsView: View {
    @State var alternateColors = AlternateColors.colors[ContentView.selectedColor]!
    private let alternateColor: [String] = ["green", "blue", "gray", "brown"]
    
    var body: some View {
        ZStack {
            alternateColors.backgroundInvert
                .ignoresSafeArea()
            List {
                // MARK: - App Icon
                Section(header: Text("App Color").font(.title2.weight(.medium)).foregroundStyle(alternateColors.background)) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing : 12) {
                            ForEach(alternateColor.indices, id: \.self) { color in
                                Button {
                                    print("Selected Color: \(self.alternateColor[color])")
                                } label: {
                                    VStack(alignment: .center) {
                                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular)
                                            .fill(AlternateColors.colors[self.alternateColor[color]]!.background)
                                            .frame(width: 80, height: 80)
                                            .padding(6)
                                        Text(alternateColor[color])
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundStyle(alternateColors.background)
                                    }
                                        
                                        
                                }
                            }
                        }
                    } // Scroll View
                    .padding(.top, 12)
                    Text("Choose your favorite app icon from the collection above.")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(alternateColors.background)
                        .font(.footnote)
                        .padding(.bottom, 12)
                    
                } // Section
                .listRowBackground(Color.clear)
            } // List
            .scrollContentBackground(.hidden)
            
        } // ZStack
        
    }
}

#Preview {
    SettingsView()
}

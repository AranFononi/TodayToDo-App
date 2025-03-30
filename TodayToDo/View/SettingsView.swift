//
//  SettingsView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 29/3/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var colorManager: ColorManager
    private let alternateColor: [String] = ["green", "blue", "gray", "brown","pink"]
    @EnvironmentObject private var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        @State var alternateColors = AlternateColors.colors[colorManager.selectedColor]!
        
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
                                    ColorManager.shared.selectedColor = self.alternateColor[color]
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
                    Text("Choose your favorite app color from the palette above.")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(alternateColors.background)
                        .font(.footnote)
                        .padding(.bottom, -8)
                    
                } // Section
                .listRowBackground(Color.clear)
                
                Section(header: Text("Light/Dark Mode").font(.title2.weight(.medium)).foregroundStyle(alternateColors.background)) {
                    Picker("Color Scheme", selection: $colorSchemeManager.selectedColorScheme) {
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    .pickerStyle(.segmented)
                    
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Contact Info").font(.title2.weight(.medium)).foregroundStyle(alternateColors.background)) {
                    
                    CustomListRowView(rowLabel: "Developer", rowIcon: "cup.and.heat.waves.fill", rowContent: "Aran Fononi")
                    CustomListRowView(rowLabel: "Github Profile", rowIcon: "network", rowLinkLabel: "Github", rowLinkDestination: "https://github.com/AranFononi")
                    CustomListRowView(rowLabel: "LinkedIn Profile", rowIcon: "point.3.filled.connected.trianglepath.dotted", rowLinkLabel: "LinkedIn", rowLinkDestination: "www.linkedin.com/in/aran-fononi-18182b265")
                    CustomListRowView(rowLabel: "Email", rowIcon: "envelope.fill", rowContent: "AranFononi@Gmail.com")
                    
                    
                }
                .listRowBackground(Color.clear)
                
                Section {
                    
                    HStack {
                        Spacer()
                        Text("Made with ❤️ and some ☕️\nMinimal & Fast Todo App")
                            .multilineTextAlignment(.center)
                            .foregroundColor(alternateColors.background)
                        Spacer()
                    }
                        
                    
                }
                .listRowBackground(Color.clear)
                
            } // List
            .scrollContentBackground(.hidden)
            .padding(.top, 24)

            
        } // ZStack
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(ColorSchemeManager.shared)
        .environmentObject(ColorManager.shared)
}

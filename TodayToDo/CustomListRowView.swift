//
//  CustomListRowView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 29/3/25.
//

import SwiftUI

struct CustomListRowView: View {
    
    // MARK: - Properties
    @State var rowLabel: String
    @State var rowIcon: String
    @State var rowContent: String? = nil
    @State var rowLinkLabel: String? = nil
    @State var rowLinkDestination: String? = nil
    @EnvironmentObject private var colorManager: ColorManager
    
    
    var body: some View {
        @State var alternateColors = AlternateColors.colors[colorManager.selectedColor]!
        
        LabeledContent {
            if let rowContent = rowContent {
                Text(rowContent)
                    .foregroundStyle(alternateColors.background)
                    .fontWeight(.heavy)
            }
            if let rowLinkLabel = rowLinkLabel , let rowLinkDestination = rowLinkDestination {
                Link(rowLinkLabel, destination: URL(string: rowLinkDestination)!)
                    .underline(true)
                    .fontWeight(.heavy)
                    .foregroundStyle(alternateColors.background)
            } else {
                EmptyView()
            }
            
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(alternateColors.background)
                        .frame(width: 30 , height: 30)
                    Image(systemName: rowIcon)
                        .foregroundStyle(alternateColors.backgroundInvert)
                        .fontWeight(.semibold)
                        
                }
                
                Text(rowLabel)
                    .foregroundStyle(alternateColors.background)
            }
        }
        
    }
    
}


#Preview {
    List {
        CustomListRowView(rowLabel: "Designer", rowIcon: "paintpalette", rowContent: "John Doe")
            .environmentObject(ColorSchemeManager.shared)
            .environmentObject(ColorManager.shared)
    }
}

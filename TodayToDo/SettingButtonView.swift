//
//  SettingButtonView.swift
//  TodayToDo
//
//  Created by Aran Fononi on 27/3/25.
//

import SwiftUI

struct SettingButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.primary)
                .frame(width: 40, height: 40)
                .clipShape(.circle)
            
            Button {
                //open settings
                print("Open Settings")
            } label: {
                Image(systemName: "gear")
                    .font(.title3.weight(.bold))
                    .foregroundColor(.primary)
                    .colorInvert()
                    
            }
                
        }
    }
}

#Preview {
    SettingButtonView()
}

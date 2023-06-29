//
//  CustomTabBarItemStyle.swift
//  fb4app
//
//  Created by Maurice Hennig on 31.03.23.
//

import SwiftUI
import TabBar

struct CustomTabBarItemStyle : TabItemStyle {
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        ZStack {
            if (isSelected) {
                Capsule()
                    .foregroundColor(Color(hex: "#f39c12"))
            }
            if (isSelected) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(Color.white)
                        .frame(width: 24.0, height: 24.0)
                    Text(title)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                }
                .padding(.leading, 8.0)
                .padding(.trailing, 14.0)
                .frame(maxWidth: .infinity)
            }else{
                Image(systemName: icon)
                    .foregroundColor(Color.black)
                    .frame(width: 24.0, height: 24.0)
            }
        }
    }
}

//
//  CustomTabBarStyle.swift
//  fb4app
//
//  Created by Maurice Hennig on 31.03.23.
//

import SwiftUI
import TabBar

struct CustomTabBarStyle  : TabBarStyle {
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .background(Color(UIColor.secondarySystemBackground))
            .frame(height: 50)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .padding(.top, 10.0)
            .padding(.leading, geometry.safeAreaInsets.leading)
    }
}

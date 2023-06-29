//
//  NavigationLazyView.swift
//  fb4app
//
//  Created by Maurice Hennig on 04.04.23.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

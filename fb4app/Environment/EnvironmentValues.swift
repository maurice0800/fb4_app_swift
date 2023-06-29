//
//  EnvironmentValues.swift
//  fb4app
//
//  Created by Maurice Hennig on 05.04.23.
//

import SwiftUI

extension EnvironmentValues {
    var dismissSheet: () -> Void {
        get { self[DismissSheeetKey.self] }
        set { self[DismissSheeetKey.self] = newValue }
    }
}

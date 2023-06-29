//
//  ElevatedButton.swift
//  fb4app
//
//  Created by Maurice Hennig on 16.04.23.
//

import SwiftUI

struct ElevatedButton: View {
    
    let title: String
    let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(title, action: action)
        .padding()
        .background(.orange)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct ElevatedButton_Previews: PreviewProvider {
    static var previews: some View {
        ElevatedButton("Elevated Button") {
            
        }
    }
}

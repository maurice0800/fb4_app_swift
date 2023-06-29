//
//  MoreListItem.swift
//  fb4app
//
//  Created by Maurice Hennig on 17.06.23.
//

import SwiftUI

struct MoreListItem<Content: View>: View {
    var icon: String
    var title: String
    var destination: () -> Content
    
    init(icon: String, title: String, @ViewBuilder content: @escaping () -> Content) {
        self.icon = icon
        self.title = title
        self.destination = content
    }
    
    var body: some View {
            NavigationLink {
                destination()
            } label: {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 20.0))
                    Text(title)
                        .font(.system(size: 20.0))
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .padding()
            }
    }
}

struct MoreListItemNoLink: View {
    var icon: String
    var title: String
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
    
    var body: some View {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20.0))
                Text(title)
                    .font(.system(size: 20.0))
                Spacer()
                Image(systemName: "chevron.forward")
            }
            .padding()
    }
}

struct MoreListItem_Previews: PreviewProvider {
    static var previews: some View {
        MoreListItem(icon: "gear", title: "Einstellungen") {
            Text("Not set")
        }
    }
}

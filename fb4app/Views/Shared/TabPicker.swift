//
//  TabPicker.swift
//  fb4app
//
//  Created by Maurice Hennig on 03.04.23.
//

import SwiftUI

struct TabPicker<T: Equatable & Hashable & RawRepresentable>: View where T.RawValue == String {
    @Binding var selectedTab: T
    
    let tabs: [T]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.tertiarySystemGroupedBackground))
                .cornerRadius(7.0)
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    ZStack {
                        Rectangle()
                            .foregroundColor(tab == selectedTab ? .orange : Color(UIColor.tertiarySystemGroupedBackground))
                            .cornerRadius(7.0)
                        Text(tab.rawValue)
                            .fixedSize(horizontal: true, vertical: false)
                            .foregroundColor(tab == selectedTab ? .white : Color(UIColor.label))
                            .padding(.horizontal, 12.0)
                            .padding(.vertical, 6.0)
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                }
            }
            .padding(2.0)
        }
        .fixedSize(horizontal: true, vertical: true)
    }
}

//struct TabPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TabPicker()
//    }
//}

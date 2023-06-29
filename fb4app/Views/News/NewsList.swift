//
//  NewsList.swift
//  fb4app
//
//  Created by Maurice Hennig on 03.04.23.
//

import SwiftUI

struct NewsList: View {
    let newsEntries: [NewsEntry]
    @Binding var searchText: String
    
    var body: some View {
        ScrollView {
            ForEach(newsEntries.filter { news in
                if (searchText.isEmpty) {
                    return true
                }
                
                return news.header.contains(searchText) || news.body.contains(searchText)
            }) { entry in
                NewsCard(entry: entry)
                Spacer()
            }
            .padding()
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        @State var x = ""
        NewsList(newsEntries: [], searchText: $x)
    }
}

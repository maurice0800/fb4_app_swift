//
//  NewsSheet.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import SwiftUI

struct NewsSheet: View {
    let entry: NewsEntry
    var replaceString: String
    let regex = "(http|https):\\/\\/([\\w_-]+(?:(?:\\.[\\w_-]+)+))([\\w.,@?^=%&:\\/~+#-]*[\\w@?^=%&\\/~+#-])"
    
    init(entry: NewsEntry) {
        self.entry = entry
        self.replaceString = entry.body.replacingOccurrences(of: regex, with: "[$0]($0)", options: .regularExpression)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(entry.header)
                        .font(.system(size: 26))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    Text(.init(replaceString))
                    Spacer()
                    Text("Veröffentlicht in \(entry.list)")
                    Text("Veröffentlicht am \(entry.date)")
                }
                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
                .navigationBarTitle("Newsdetails")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct NewsSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewsSheet(entry: NewsEntry(header: "", body: "", list: "", date: ""))
    }
}

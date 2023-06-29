//
//  NewsCard.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import SwiftUI
import CoreData

struct NewsCard: View {
    @State var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    let entry: NewsEntry
    let savedObjectIdentifier: NSManagedObjectID?
    
    init(entry: NewsEntry, savedObjectIdentifier: NSManagedObjectID? = nil) {
        self.entry = entry
        self.savedObjectIdentifier = savedObjectIdentifier
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(entry.header)
                    .lineLimit(1)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                Rectangle()
                    .fill(Color.orange)
                    .frame(height: 2)
                Text(entry.body)
                    .lineLimit(4)
                    .font(.system(size: 16))
                Rectangle()
                    .fill(Color.orange)
                    .frame(height: 2)
                HStack {
                    Text(entry.list)
                        .font(.system(size: 16))
                        .lineLimit(1)
                    Spacer()
                    Text(entry.date)
                        .font(.system(size: 16))
                        .lineLimit(1)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                showingSheet.toggle()
            })
            .sheet(isPresented: $showingSheet, content: {
                NewsSheet(entry: entry)
            })
            .padding(10)
            .background(Color(UIColor.systemBackground))
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            )
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 5, x: 0, y: 2.0)
            .frame(height: 150)
        }
        .contextMenu {
            if (savedObjectIdentifier != nil) {
                Button {
                    viewContext.delete(viewContext.object(with: savedObjectIdentifier!))
                    try! viewContext.save()
                } label: {
                    Label("Löschen", systemImage: "trash")
                }
            } else {
                Button {
                    let savedEntry = SavedNewsEntry(context: viewContext)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm:ss"
                    
                    savedEntry.body = entry.body
                    savedEntry.header = entry.header
                    savedEntry.list = entry.list
                    savedEntry.date = dateFormatter.date(from: entry.date)!
                    try! viewContext.save()
                } label: {
                    Label("Speichern", systemImage: "square.and.arrow.down")
                }
            }
        }
    }
}

struct NewsCard_Previews: PreviewProvider {
    static var previews: some View {
        NewsCard(entry: NewsEntry(header: "", body: "", list: "", date: ""), savedObjectIdentifier: nil)
    }
}

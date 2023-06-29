//
//  NewsOverview.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import SwiftUI
import CoreData

enum ViewTab : String, CaseIterable, Equatable {
    case new = "Aktuelles", saved = "Gepseichert"
}

struct NewsOverview: View {
    let store = NewsStore()
    let dateFormatter = DateFormatter()
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var savedItems: FetchedResults<SavedNewsEntry>
    
    @State var isLoading = true
    @State var currentEntries: [NewsEntry]?
    @State var searchText = ""
    @State var selectedTab: ViewTab = .new
    @State var showSearchBox = false
    
    init() {
        dateFormatter.dateFormat = "dd.MM.yyyy - hh:mm:ss"
    }
    
    var body: some View {
        let selectedIndex: Binding<Int> = Binding(get: { ViewTab.allCases.firstIndex(of: selectedTab)! }, set: { newValue in
            selectedTab = ViewTab.allCases[newValue]
        })
        
        NavigationStack {
                VStack {
                    if (showSearchBox) {
                     SearchBox(text: $searchText, isVisible: $showSearchBox)
                    } else {
                        TabPicker<ViewTab>(selectedTab: $selectedTab, tabs: ViewTab.allCases)
                    }
                    
                    if (isLoading) {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        SnapCarousel(index: selectedIndex, items: ViewTab.allCases) { item in
                            if (item == .new) {
                                NewsList(newsEntries: currentEntries!, searchText: $searchText)
                                .refreshable {
                                    refreshNewsItems()
                                }
                            }
                            
                            if (item == .saved) {
                                let convertedSavedItems = savedItems.map { item in
                                    return NewsEntry(header: item.header!, body: item.body!, list: item.list!, date: dateFormatter.string(from: item.date!))
                                }
                                
                                if (convertedSavedItems.count > 0){
                                    NewsList(newsEntries: convertedSavedItems, searchText: $searchText)
                                } else {
                                    Text("Aktuell sind noch keine News gespeichert")
                                }
                            }
                        }
                        
                        .transition(.opacity)
                        Spacer()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity,  maxHeight: .infinity)
                .onAppear {
                    refreshNewsItems()
                }
                .navigationTitle("News")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        if (showSearchBox) {
                            Button {
                                showSearchBox = false
                                searchText = ""
                            } label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.black)
                            }
                        } else {
                            Button {
                                showSearchBox = true
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
        }
    }
    
    func refreshNewsItems() {
        self.isLoading = true
        self.currentEntries = nil
        
        store.getAll { entries in
            withAnimation(.easeOut) {
                self.currentEntries = entries
                self.isLoading = false
            }
            
        }
    }
}

struct NewsOverview_Previews: PreviewProvider {
    static var previews: some View {
        NewsOverview()
    }
}

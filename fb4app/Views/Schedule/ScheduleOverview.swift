//
//  ScheduleOverview.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import SwiftUI

struct ScheduleOverview: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.timeBegin)],
        animation: Animation.easeInOut)
    private var savedItems: FetchedResults<ScheduleItem>
    
    @State var displayAddSheet = false
    @State var selectedWeekday: ScheduleWeekday = UserDefaultsHelper.shared.bool(key: .showCurrentWeekday) ? ScheduleWeekday.fromDate(date: Date()) : .monday
    
    var body: some View {
        let selectedIndex: Binding<Int> = Binding(get: { ScheduleWeekday.allCases.firstIndex(of: selectedWeekday)! }, set: { newValue in
            selectedWeekday = ScheduleWeekday.allCases[newValue]
        })
        
        NavigationStack {
            VStack {
                TabPicker<ScheduleWeekday>(selectedTab: $selectedWeekday, tabs: ScheduleWeekday.allCases)
                SnapCarousel(index: selectedIndex, items: ScheduleWeekday.allCases) { weekday in
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(savedItems.filter({ item in
                                return item.weekday == weekday.toApiDay()
                            }), id: \.self) { item in
                                if #available(iOS 16.0, *) {
                                    ScheduleCard(item: item)
                                        .transition(AnyTransition.push(from: .leading))
                                } else {
                                    ScheduleCard(item: item)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button  {
                        displayAddSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
            .navigationTitle("Stundenplan")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $displayAddSheet) {
                AddSchedulePage()
                    .environment(\.dismissSheet, { displayAddSheet = false })
            }
            .onAppear {
                //PortalStore.getHtmlString(username: "", password: "") { result, error in
                 //   print(result)
                //}
            }
        }
    }
}

struct ScheduleOverview_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleOverview().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

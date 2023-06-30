//
//  ScheduleOverview.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import SwiftUI

enum ScheduleWeekday : String, CaseIterable, Equatable {
    case monday = "Mo"
    case tuesday = "Di"
    case wednesday = "Mi"
    case thursday = "Do"
    case friday = "Fr"
    
    func toApiDay() -> String {
        switch self {
        case .monday:
            return "Mon"
        case .tuesday:
            return "Tue"
        case .wednesday:
            return "Wed"
        case .thursday:
            return "Thu"
        case .friday:
            return "Fri"
        }
    }
    
    static func fromDate(date: Date) -> ScheduleWeekday {
        let dateIndex = Calendar.current.component(.weekday, from: date)
        
        switch(dateIndex) {
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        default:
            return .monday
        }
    }
    
    func toLocalizedWeekday() -> String {
        switch self {
        case .monday:
            return "Montag"
        case .tuesday:
            return "Dienstag"
        case .wednesday:
            return "Mittwoch"
        case .thursday:
            return "Donnerstag"
        case .friday:
            return "Freitag"
        }
    }
}

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
                AddOfficialSchedulePage()
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

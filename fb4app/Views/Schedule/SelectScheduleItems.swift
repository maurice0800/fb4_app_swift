//
//  SelectScheduleItems.swift
//  fb4app
//
//  Created by Maurice Hennig on 04.04.23.
//

import SwiftUI
import CoreData

struct SelectScheduleItems: View {
    @Environment(\.dismissSheet) private var dismiss
    @Environment(\.managedObjectContext) private var context
    @State var selectedWeekday: ScheduleWeekday = .monday
    @State var newItems = [ScheduleItem]()
    @State var selectedItems = [ScheduleItem]()
    
    let tempContext: NSManagedObjectContext
    
    let sname: String
    let grade: String
    
    init(sname: String, grade: String) {
        self.sname = sname
        self.grade = grade
        tempContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    var body: some View {
        let selectedIndex: Binding<Int> = Binding(get: { ScheduleWeekday.allCases.firstIndex(of: selectedWeekday)! }, set: { newValue in
            selectedWeekday = ScheduleWeekday.allCases[newValue]
        })
        
        VStack {
            TabPicker<ScheduleWeekday>(selectedTab: $selectedWeekday, tabs: ScheduleWeekday.allCases)
            SnapCarousel(index: selectedIndex, items: ScheduleWeekday.allCases) { weekday in
                ScrollView {
                    ForEach(newItems.filter({ item in
                        return item.weekday == weekday.toApiDay()
                    }), id: \.self) { item in
                        ScheduleCard(item: item, editable: true)
                            .simultaneousGesture(
                                TapGesture()
                                    .onEnded({ _ in
                                        let index = selectedItems.firstIndex(of: item)
                                        
                                        if (index == nil) {
                                            selectedItems.append(item)
                                        } else {
                                            selectedItems.remove(at: index!)
                                        }
                                    }
                                )
                            )
                            .animation(Animation.easeOut(duration: 0.6).delay(0.5), value: true)
                    } .padding()
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button  {
                    for item in selectedItems {
                        let newItem = ScheduleItem(context: context)
                        
                        newItem.color = item.color
                        newItem.courseTitle = item.courseTitle
                        newItem.courseType = item.courseType
                        newItem.group = item.group
                        newItem.room = item.room
                        newItem.teacher = item.teacher
                        newItem.timeEnd = item.timeEnd
                        newItem.timeBegin = item.timeBegin
                        newItem.weekday = item.weekday
                    }
                    
                    try! context.save()
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
        .onAppear {
            ScheduleStore().getSaveableScheduleItems(context: tempContext, sname: sname, grade: grade) { items in
                newItems = items
            }
        }
        .navigationTitle("Neue Elemente wählen")
    }
}

//struct SelectScheduleItems_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectScheduleItems()
//    }
//}

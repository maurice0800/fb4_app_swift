//
//  AddCustomScheduleForm.swift
//  fb4app
//
//  Created by Maurice Hennig on 16.04.23.
//

import SwiftUI

struct AddCustomScheduleForm: View {
    @Environment(\.dismissSheet) var dismiss
    @Environment(\.managedObjectContext) var context
    
    @State var name: String = ""
    @State var room: String = ""
    @State var teacher: String = ""
    @State var teacherShort: String = ""
    @State var weekday: ScheduleWeekday = .monday
    @State var startTime: Date = Date()
    @State var endTime: Date = Date() + 60 * 60
    
    var body: some View {
        Section("Kursdetails") {
            TextField("Kursname", text: $name)
            TextField("Raum", text: $room)
            TextField("Lehrender", text: $teacher)
            TextField("Kürzel", text: $teacherShort)
        }
        Section("Zeiten") {
            Picker("Wochentag", selection: $weekday) {
                ForEach(ScheduleWeekday.allCases, id: \.self) { day in
                    Text(day.toLocalizedWeekday()).tag(day)
                }
            }
            DatePicker("Startzeit", selection: $startTime, displayedComponents: .hourAndMinute)
            DatePicker("Endzeit", selection: $endTime, displayedComponents: .hourAndMinute)
        }
        Button {
            let newItem = ScheduleItem(context: context)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            newItem.courseTitle = name
            newItem.courseType = "C"
            newItem.room = room
            newItem.teacher = teacher
            newItem.group = "*"
            newItem.weekday = weekday.toApiDay()
            newItem.timeBegin = dateFormatter.string(from: startTime)
            newItem.timeEnd = dateFormatter.string(from: endTime)
            
            dismiss()
        } label: {
            Text("Speichern")
        }

    }
}

struct AddCustomScheduleForm_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomScheduleForm()
    }
}

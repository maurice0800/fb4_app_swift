//
//  ScheduleWeekday.swift
//  fb4app
//
//  Created by Maurice Hennig on 30.06.23.
//

import Foundation

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

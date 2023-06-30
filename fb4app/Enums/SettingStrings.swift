//
//  SettingStrings.swift
//  fb4app
//
//  Created by Maurice Hennig on 30.06.23.
//

import SwiftUI

enum SettingString: String, CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
    
    case showCurrentWeekday;
    case increaseBrightnessInTicket;
    case showNotificationOnNews;
}

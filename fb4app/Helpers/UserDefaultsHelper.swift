//
//  UserDefaultsHelper.swift
//  fb4app
//
//  Created by Maurice Hennig on 30.06.23.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private let defaults = UserDefaults.standard

    init() {}
    
    func set(_ value: Any?, key: SettingString) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    func get(key: SettingString) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    
    func bool(key: SettingString) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
}

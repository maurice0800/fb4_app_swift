//
//  StringExtensions.swift
//  fb4app
//
//  Created by Maurice Hennig on 05.04.23.
//

import Foundation

extension String {
    // https://stackoverflow.com/a/39215372
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}

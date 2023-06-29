//
//  CourseInfo.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import Foundation

struct CourseOfStudy : Decodable, Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let sname: String
    let grades: [Grade]
}

struct Grade: Decodable, Identifiable, Hashable {
    let id = UUID()
    
    let grade: String
    let modified: Int
}

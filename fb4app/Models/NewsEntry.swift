//
//  NewsEntry.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import Foundation

struct NewsEntry : Decodable, Identifiable {
    let id = UUID()
    let header: String
    let body: String
    let list: String
    let date: String
}

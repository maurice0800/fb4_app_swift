//
//  Meal.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import Foundation

struct Meal : Decodable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let type: String
    let priceEmployee: Float
    let priceStudent: Float
    let priceGuests: Float
    let supplies: [String]
}

struct CanteenMeals : Decodable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let meals: [Meal]
}

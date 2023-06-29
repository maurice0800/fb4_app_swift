//
//  Canteens.swift
//  fb4app
//
//  Created by Maurice Hennig on 17.04.23.
//

import Foundation

enum Canteen : String, CaseIterable {
    case hauptmensa = "hauptmensa";
    case foodFakultaet = "food-fakultaet";
    case galerie = "galerie";
    case kostbar = "mensa-kostbar";
    case archeteria = "archeteria";
    case maxOphuelsPlatz = "max-ophuels-platz";
    case genusswerkstatt = "genusswerkstatt";
    case mensaSued = "mensa-sued";
    case restaurantCalla = "restaurant-calla";
    case vital = "vital";
    case cafec = "cafec";
    case sonnenstrasse = "sonnenstrasse";
    
    
    func getFriendlyName() -> String {
        switch(self) {
        case .hauptmensa: return "Hauptmensa"
        case .foodFakultaet: return "Food Fakultät"
        case .archeteria: return "Archeteria"
        case .galerie: return "Galerie"
        case .kostbar: return "Kostbar"
        case .vital: return "vital"
        case .cafec: return "Café C"
        case .mensaSued: return "Mensa Süd"
        case .sonnenstrasse: return "Mensa Sonnenstraße"
        case .maxOphuelsPlatz: return "Max-Ophuels-Platz"
        case .genusswerkstatt: return "Genusswerkstatt"
        case .restaurantCalla: return "Restaurant Calla"
        }
    }
    
    func getLocation() -> String {
        switch(self) {
        case .kostbar, .maxOphuelsPlatz, .sonnenstrasse:
            return "fh-dortmund"
        default:
            return "tu-dortmund"
        }
    }
}

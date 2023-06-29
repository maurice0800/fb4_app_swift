//
//  CanteenStore.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import Foundation
import Alamofire

class CanteenStore {
    func getMealsForDay(dayString: String, canteen: Canteen, complete: @escaping (CanteenMeals) -> ()) {
        let url = "https://fb4app.hemacode.de/getMeals.php?location=\(canteen.getLocation())&mensa=\(canteen.rawValue)&date=\(dayString)"
        
        AF.request(url).responseDecodable(of: CanteenMeals.self) { response in
            complete(response.value!)
        }
    }
}

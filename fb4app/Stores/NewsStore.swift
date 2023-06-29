//
//  NewsStore.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import Foundation
import Alamofire

class NewsStore : ObservableObject {
    let url = "https://fb4app.hemacode.de/getNews.php"
    
    func getAll(completion: @escaping ([NewsEntry]) -> ()) {
        AF.request(url).responseDecodable(of: [NewsEntry].self) { response in
            completion(response.value!)
        }
    }
}

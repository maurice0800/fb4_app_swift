//
//  CourseInfoStore.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import Foundation
import Alamofire

struct InputCouseInfo : Decodable {
    let name: String?
    let sname: String?
    let grades: [Grade]?
}

class CourseOfStudyStore {
    func getAvailableCourses(complete: @escaping ([CourseOfStudy]) -> ()) {
        let url = "https://ws.inf.fh-dortmund.de/fbws/current/rest/CourseOfStudy/?Accept=application/json"
        
        AF.request(url).responseDecodable(of: [String: InputCouseInfo].self) { response in
            complete(Array(response.value!.values)
                .filter({input in
                    input.name != nil && input.sname != nil && input.grades != nil
                })
                .map({ input in
                    return CourseOfStudy(name: input.name!, sname: input.sname!, grades: input.grades!)
                })
            )
        }
    }
}

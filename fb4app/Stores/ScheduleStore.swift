//
//  ScheduleStore.swift
//  fb4app
//
//  Created by Maurice Hennig on 02.04.23.
//

import Foundation
import Alamofire
import CoreData

struct ScheduleItemDTO: Decodable {
    let name: String
    let courseType: String
    let lecturerName: String
    let studentSet: String
    let roomId: String
    let timeBegin: String
    let timeEnd: String
    let weekday: String
}

class ScheduleStore {
    func getSaveableScheduleItems(context: NSManagedObjectContext, sname: String, grade: String, complete: @escaping ([ScheduleItem]) -> ()) {
        let url = "https://ws.inf.fh-dortmund.de/fbws/current/rest/CourseOfStudy/\(sname)/\(grade)/Events?Accept=application/json&studentSet=*"
        
        AF.request(url).responseDecodable(of: [ScheduleItemDTO].self) { response in
            var returnList = [ScheduleItem]()
            
            for item in response.value! {
                let newItem = ScheduleItem(context: context)
                newItem.room = item.roomId
                newItem.courseType = item.courseType
                newItem.courseTitle = item.name
                newItem.group = item.studentSet
                newItem.teacher = item.lecturerName
                newItem.timeEnd = item.timeEnd.leftPadding(toLength: 4, withPad: "0")
                newItem.timeBegin = item.timeBegin.leftPadding(toLength: 4, withPad: "0")
                newItem.weekday = item.weekday
                
                newItem.timeBegin!.insert(":", at: newItem.timeBegin!.index(newItem.timeBegin!.startIndex, offsetBy: 2))
                newItem.timeEnd!.insert(":", at: newItem.timeEnd!.index(newItem.timeEnd!.startIndex, offsetBy: 2))
                
                returnList.append(newItem)
            }
            
            complete(returnList)
        }
    }
}

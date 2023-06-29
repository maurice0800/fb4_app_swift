//
//  PortalStore.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import Foundation
import Alamofire

class PortalStore {
    public static func getHtmlString(username: String, password: String, handler: @escaping (String, String?) -> ()) {
        let loginUrl = "https://portal.fh-dortmund.de/qisserver/rds?state=user&type=1&category=auth.login"
        let initUrl = "https://portal.fh-dortmund.de/qisserver/pages/sul/examAssessment/personExamsReadonly.xhtml?_flowId=examsOverviewForPerson-flow&_flowExecutionKey=e1s1"
        
        let headers: HTTPHeaders = [
            "Host": "portal.fh-dortmund.de",
            "Accept": "*/*",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let updateHeaders: [String: String] = [
            "javax.faces.ViewState": "e1s1",
            "javax.faces.behavior.event": "action",
            "javax.faces.partial.event": "click",
            "javax.faces.source": "examsReadonly:overviewAsTreeReadonly:tree:expandAll2",
            "javax.faces.partial.ajax": "true",
            "javax.faces.partial.execute": "examsReadonly:overviewAsTreeReadonly:tree:expandAll2",
            "javax.faces.partial.render": "examsReadonly:overviewAsTreeReadonly:tree:expandAll2 examsReadonly:overviewAsTreeReadonly:tree:ExamOverviewForPersonTreeReadonly",
        ]
        
        let parameters: [String: String] = [
            "asdf": username,
            "fdsa": password
        ]
        
        AF.request(loginUrl, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers)
            .response { loginResponse in
                if (loginResponse.response?.statusCode == 200) {
                    AF.request(initUrl, method: .get).response { initResponse in
                        if (initResponse.response?.statusCode == 200) {
                            AF.request(initUrl, method: .post, parameters: updateHeaders, encoder: URLEncodedFormParameterEncoder.urlEncodedForm).response { updateResponse in
                                
                                handler(String(data: updateResponse.data!, encoding: .utf8)!, nil)
                                
//                                let htmlContent = String(data: updateResponse.data!, encoding: .utf8)!.slice(from:
//                                        """
//                                            <update id="examsReadonly:overviewAsTreeReadonly:tree:ExamOverviewForPersonTreeReadonly"><![CDATA[
//    """, to: "]]")!
                                
                            }
                        } else {
                            debugPrint(initResponse)
                        }
                    }
                } else {
                    debugPrint(loginResponse)
                }
            }
    }

}

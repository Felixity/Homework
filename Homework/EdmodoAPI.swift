//
//  EdmodoAPI.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EdmodoAPI {
    private let baseURL = "https://api.edmodo.com"
    private let assignmentsEndpoint = "/assignments"
    private let assignmentSubmissionsEndpoint = "/assignment_submissions"
    private let accessToken = "12e7eaf1625004b7341b6d681fa3a7c1c551b5300cf7f7f3a02010e99c84695d"
    
    private var _sharedInstance: EdmodoAPI?
    var sharedInstance: EdmodoAPI {
        get {
            if _sharedInstance == nil {
                _sharedInstance = EdmodoAPI()
            }
            return _sharedInstance!
        }
    }
    
    func fetchAssignments(page: Int, limit: Int, successCallback: @escaping ([Assignment])->(), error: ((Error?)->())?) {
        
        let stringURL = baseURL + assignmentsEndpoint
        let parameters = createParameters(page, limit, nil, nil)

        Alamofire.request(stringURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [:]).validate().responseJSON(completionHandler: { response in
            switch response.result {
                case .success(let value):
                    let jsonArray = JSON(value)
                    var assignments: [Assignment] = []
                    
                    for json in jsonArray.arrayValue {
                        assignments.append(Assignment(json: json))
                    }
                    successCallback(assignments)
            
                case .failure(let errorResponse):
                    if let errorCallback = error {
                        errorCallback(errorResponse)
                    }
            }

        })
    }
    
    func fetchSubmissions(page: Int, limit: Int, assignmentId: Int, assignmentCreatorId: Int, successCallback: @escaping ([Submission])->(), error: ((Error?)->())?) {
        
        let stringURL = baseURL + assignmentSubmissionsEndpoint
        let parameters = createParameters(page, limit, assignmentId, assignmentCreatorId)

        Alamofire.request(stringURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [:]).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonArray = JSON(value)
                var submissions: [Submission] = []
                
                for json in jsonArray.arrayValue {
                    submissions.append(Submission(student: Student(json: json), json: json))
                }
                successCallback(submissions)
                
            case .failure(let errorResponse):
                if let errorCallback = error {
                    errorCallback(errorResponse)
                }
            }
        }
    }
    
    private func createParameters(_ page: Int, _ limit: Int, _ assignmentId: Int?, _ assignmentCreatorId: Int?) -> Parameters {
        
        var parameters: Parameters = ["access_token" : accessToken]
        
        parameters["page"] = page
        parameters["per_page"] = limit
        
        if let assignmentId = assignmentId {
            parameters["assignment_id"] = assignmentId
        }
        
        if let assignmentCreatorId = assignmentCreatorId {
            parameters["assignment_creator_id"] = assignmentCreatorId
        }
        
        return parameters
    }
}

//
//  Submission.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import Foundation
import SwiftyJSON

class Submission {
    var student: Student
    var content: String {
        return json["content"].stringValue
    }
    var date: String {
        let stringDate = json["submitted_at"].stringValue
        return stringDate.convertDate(to: "MMM dd, YYYY")
    }
    
    private var json: JSON
    
    init(student: Student, json: JSON) {
        self.student = student
        self.json = json
    }
}

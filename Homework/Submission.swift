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
    var content: String
    var date: String
    
    init(student: Student, json: JSON) {
        self.student = student
        self.content = json["content"].stringValue
        self.date = json["submitted_at"].stringValue.convertDate(to: "MMM dd, YYYY")
    }
}

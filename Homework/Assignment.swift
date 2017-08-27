//
//  Assignment.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import Foundation
import SwiftyJSON

class Assignment {
    var title: String
    var content: String
    var dueDate: String
    var id: Int
    var creatorId: Int
    
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.content = json["description"].stringValue
        self.dueDate = json["due_at"].stringValue.convertDate(to: "MMM dd, YYYY")
        self.id = json["id"].intValue
        self.creatorId = json["creator"]["id"].intValue
    }
    
    init(title: String, content: String, dueDate: String, id: Int, creatorId: Int) {
        self.title = title
        self.content = content
        self.dueDate = dueDate
        self.id = id
        self.creatorId = creatorId
    }
}

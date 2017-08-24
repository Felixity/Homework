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
    
    var title: String {
        return json["title"].stringValue
    }
    var content: String {
        return json["description"].stringValue
    }
    var dueDate: String {
        let stringDate = json["due_at"].stringValue
        return  stringDate.convertDate(to: "MMM dd, YYYY")
    }
    var id: Int {
        return json["id"].intValue
    }
    var creatorId: Int {
        return json["creator"]["id"].intValue
    }
    
    private var json: JSON
    
    init(json: JSON) {
        self.json = json
    }
}

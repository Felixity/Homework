//
//  Student.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import Foundation
import SwiftyJSON

class Student {
    var firstName: String {
        return json["creator"]["first_name"].stringValue
    }
    var lastName: String {
        return json["creator"]["last_name"].stringValue
    }
    var avatarLarge: String {
        return json["creator"]["avatars"]["large"].stringValue
    }
    
    private var json: JSON
    
    init(json: JSON) {
        self.json = json
    }
}

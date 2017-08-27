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
    var firstName: String
    var lastName: String
    var avatarLarge: String
    var fullName: String {
        return firstName + " " + lastName
    }
    
    init(json: JSON) {
        self.firstName = json["creator"]["first_name"].stringValue
        self.lastName = json["creator"]["last_name"].stringValue
        self.avatarLarge = json["creator"]["avatars"]["large"].stringValue
    }
}

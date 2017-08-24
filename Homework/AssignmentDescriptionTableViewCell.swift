//
//  AssignmentDescriptionTableViewCell.swift
//  Homework
//
//  Created by Laura on 8/23/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

class AssignmentDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var details: String? {
        didSet {
            if let details = details {
                descriptionLabel.text = details
            }
        }
    }
}

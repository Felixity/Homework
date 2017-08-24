//
//  AssignmentTableViewCell.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueAtLabel: UILabel!
    
    var assignment: Assignment? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        // reset any existing info
        titleLabel.text = nil
        dueAtLabel.text = nil
        
        if let assignment = assignment {
            titleLabel.text = assignment.title
            dueAtLabel.text = "due " + assignment.dueDate
        }
    }
}

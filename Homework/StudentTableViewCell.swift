//
//  StudentTableViewCell.swift
//  Homework
//
//  Created by Laura on 8/23/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit
import AFNetworking

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var submissionDateLabel: UILabel!
    
    var submission: Submission? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        // reset the existing values
        avatarImageView.image = nil
        nameLabel.text = nil
        submissionDateLabel.text = nil
        
        if let submission = submission {
            nameLabel.text = submission.student.fullName
            submissionDateLabel.text = "turned in " + submission.date
            if let url = URL(string: submission.student.avatarLarge) {
                avatarImageView.setImageWith(url)
            }
        }
    }
}

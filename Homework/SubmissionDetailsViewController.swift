//
//  SubmissionDetailsViewController.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit
import AFNetworking

class SubmissionDetailsViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var submission: Submission!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    private func updateUI() {
        nameLabel.text = submission.student.firstName + " " + submission.student.lastName
        dateLabel.text = "turned in " + submission.date
        descriptionLabel.text =  submission.content
        if let url = URL(string: submission.student.avatarLarge) {
            avatarImageView.setImageWith(url)
        }
    }
}

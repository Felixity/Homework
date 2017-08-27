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
    var navigationBarTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarTitle()
        
        updateUI()
    }
    
    private func updateUI() {
        nameLabel.text = submission.student.fullName
        dateLabel.text = "turned in " + submission.date
        descriptionLabel.text =  submission.content
        if let url = URL(string: submission.student.avatarLarge) {
            avatarImageView.setImageWith(url)
        }
    }
    
    private func setNavigationBarTitle() {
        // Resize the title in navigation bar dynamically
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        titleLabel.text = navigationBarTitle
        titleLabel.adjustsFontSizeToFitWidth = true
        navigationItem.titleView = titleLabel
    }
}

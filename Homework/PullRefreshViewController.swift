//
//  PullRefreshViewController.swift
//  Homework
//
//  Created by Laura on 8/24/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

class PullRefreshViewController: UIViewController {

    let refreshControl = UIRefreshControl()
    let errorMessageView = UIView(frame: CGRect(x: 0.0, y: 64.0, width: UIScreen.main.bounds.width, height: 20))
    let errorMessageLabel = UILabel(frame: CGRect(x: 8.0, y: 4.0, width: UIScreen.main.bounds.width, height: 13))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupErrorMessage()
        setupRefreshControl()
    }

    private func setupErrorMessage() {
        errorMessageLabel.textColor = UIColor.white
        errorMessageLabel.font = errorMessageLabel.font.withSize(13.0)
        errorMessageLabel.textAlignment = NSTextAlignment.center
        
        errorMessageView.backgroundColor = UIColor.darkGray
        errorMessageView.addSubview(errorMessageLabel)
        view.addSubview(errorMessageView)
        
        errorMessageView.isHidden = true
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
    }
    
    @objc private func refreshControlAction() {
        loadDataAfterPullRefresh()
    }
    
    func loadDataAfterPullRefresh() {}
}

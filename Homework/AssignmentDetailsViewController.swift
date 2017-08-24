//
//  AssignmentDetailsViewController.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit
import JGProgressHUD

class AssignmentDetailsViewController: PullRefreshViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var assignment: Assignment!
    fileprivate var submissions: [Submission] = []
    fileprivate var isMoreDataLoading = true
    fileprivate let pageLimit = 20
    fileprivate var currentPage = 1
    
    private lazy var onSubmissionRecived: ([Submission])->() = { result in
        self.loadingIndicatorView?.dismiss()
        if self.refreshControl.isRefreshing {
            self.submissions = []
            
            self.errorMessageLabel.text = nil
            self.errorMessageView.isHidden = true
            self.refreshControl.endRefreshing()
        }
        self.submissions += result
        self.isMoreDataLoading = !(self.submissions.count < self.currentPage * self.pageLimit)
        self.tableView.reloadData()
    }
    
    private lazy var onErrorHandler: ((Error?) -> ())? = { error in
        self.loadingIndicatorView?.dismiss()
        if let error = error {
            self.errorMessageLabel.text = error.localizedDescription
            self.errorMessageView.isHidden = false
            
            self.refreshControl.endRefreshing()
        }
    }
    
    private let loadingIndicatorView = JGProgressHUD.init(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.insertSubview(refreshControl, at: 0)
    
        setNavigationBarTitle()
        
        loadingIndicatorView?.show(in: tableView)
        
        loadData()
    }
    
    private func setNavigationBarTitle() {
        // Resize the title in navigation bar dynamically
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        titleLabel.text = assignment.title
        titleLabel.adjustsFontSizeToFitWidth = true
        navigationItem.titleView = titleLabel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSubmission" {
            if let destination = segue.destination as? SubmissionDetailsViewController, let cell = sender as? StudentTableViewCell {
                destination.submission = cell.submission
                destination.navigationBarTitle = assignment.title
            }
        }
    }
    
    fileprivate func loadData() {
        EdmodoAPI().sharedInstance.fetchSubmissions(page: currentPage, limit: pageLimit, assignmentId: assignment.id, assignmentCreatorId: assignment.creatorId, successCallback: onSubmissionRecived, error: onErrorHandler)
    }
    
    override func loadDataAfterPullRefresh() {
        currentPage = 1
        loadData()
    }
}

extension AssignmentDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return submissions.count + 1 // assignment's description + number of students listed in the table
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            cell = createAssignmentDescriptionTableViewCell(indexPath: indexPath)
        }
        else {
            cell = createStudentTableViewCell(indexPath: indexPath)
        }
        
        return cell
    }
    
    private func createAssignmentDescriptionTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentDescriptionCell", for: indexPath) as! AssignmentDescriptionTableViewCell
        cell.details = assignment.content
        return cell
    }
    
    private func createStudentTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentDetailsCell", for: indexPath) as! StudentTableViewCell
        cell.submission = submissions[indexPath.row - 1] // we need to keep in mind that the first cell displays the assignment's description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (submissions.count - indexPath.row == pageLimit) && isMoreDataLoading {
            currentPage += 1
            loadData()
        }
    }
}

//
//  AssignmentsListViewController.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

class AssignmentsListViewController: PullRefreshViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var assignments: [Assignment] = []
    fileprivate var isMoreDataLoading = true
    fileprivate let pageLimit = 20
    fileprivate var currentPage = 1
    
    private lazy var onAssignmentsReceived: ([Assignment])->() = { result in
        if self.refreshControl.isRefreshing {
            self.assignments = []
            
            self.errorMessageLabel.text = nil
            self.errorMessageView.isHidden = true
            self.refreshControl.endRefreshing()
        }
        self.assignments += result
        self.isMoreDataLoading = !(self.assignments.count < self.currentPage * self.pageLimit)
        
        self.tableView.reloadData()
    }
    
    private lazy var onErrorHandler: ((Error?)->())? = { error in
        if let error = error {
            self.errorMessageLabel.text = error.localizedDescription
            self.errorMessageView.isHidden = false
            
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.insertSubview(refreshControl, at: 0)
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAssignmentDetails" {
            if let destination = segue.destination as? AssignmentDetailsViewController, let cell = sender as? AssignmentTableViewCell {
                destination.assignment = cell.assignment
            }
        }
    }
    
    fileprivate func loadData() {
        EdmodoAPI().sharedInstance.fetchAssignments(page: currentPage, limit: pageLimit, successCallback: onAssignmentsReceived, error: onErrorHandler)
    }
    
    override func loadDataAfterPullRefresh() {
        currentPage = 1
        loadData()
    }
}

extension AssignmentsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentTableViewCell
        cell.assignment = assignments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (assignments.count - indexPath.row == pageLimit) && isMoreDataLoading {
            currentPage += 1
            loadData()
        }
    }
}

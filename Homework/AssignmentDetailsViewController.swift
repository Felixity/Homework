//
//  AssignmentDetailsViewController.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

class AssignmentDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var assignment: Assignment!
    fileprivate var submissions: [Submission] = []
    
    private lazy var onSubmissionRecived: ([Submission])->() = { result in
        self.submissions = result
        self.tableView.reloadData()
    }
    
    private lazy var onErrorHandler: ((Error?) -> ())? = { error in
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    private var currentPage = 1
    private let pageLimit = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    
        EdmodoAPI().sharedInstance.fetchSubmissions(page: currentPage, limit: pageLimit, assignmentId: assignment.id, assignmentCreatorId: assignment.creatorId, successCallback: onSubmissionRecived, error: onErrorHandler)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSubmission" {
            if let destination = segue.destination as? SubmissionDetailsViewController, let cell = sender as? StudentTableViewCell {
                destination.submission = cell.submission
            }
        }
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
}

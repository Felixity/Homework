//
//  AssignmentsListViewController.swift
//  Homework
//
//  Created by Laura on 8/22/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

class AssignmentsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var assignments: [Assignment] = []
    
    private lazy var onAssignmentsReceived: ([Assignment])->() = { result in
        self.assignments = result
        self.tableView.reloadData()
    }
    
    private lazy var onErrorHandler: ((Error?)->())? = { error in
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
        
        EdmodoAPI().sharedInstance.fetchAssignments(page: currentPage, limit: pageLimit, successCallback: onAssignmentsReceived, error: onErrorHandler)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAssignmentDetails" {
            if let destination = segue.destination as? AssignmentDetailsViewController, let cell = sender as? AssignmentTableViewCell {
                destination.assignment = cell.assignment
            }
        }
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
}

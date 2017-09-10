//
//  ComposeAssignmentViewController.swift
//  Homework
//
//  Created by Laura on 8/25/17.
//  Copyright © 2017 Laura. All rights reserved.
//

import UIKit

protocol ComposeAssignmentViewControllerDelegate: class {
    func post(newAssignment: Assignment)
}

class ComposeAssignmentViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    weak var delegate: ComposeAssignmentViewControllerDelegate?
    var creatorId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDescriptionTextView()
        
        titleTextField.becomeFirstResponder()
    }

    private func setupDescriptionTextView() {
        descriptionTextView.delegate = self
        descriptionTextView.text = "Add description here"
        descriptionTextView.textColor = UIColor.textViewColor
        descriptionTextView.layer.borderColor = UIColor.textViewColor?.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 4
    }
    
    @IBAction func onCancelPress(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostPress(_ sender: UIBarButtonItem) {
        if titleTextField.text == "" || descriptionTextView.text == "" || descriptionTextView.textColor == UIColor.textViewColor {
            let alertController = UIAlertController(title: "Error", message: "Please fill in all missing fields!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            titleTextField.resignFirstResponder()
            
            guard let creatorId = creatorId  else {
                presentingViewController?.dismiss(animated: true, completion: nil)
                return
            }
            
            let date = dueDatePicker.date
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, YYYY"
            
            // The IDs of all local assignments was set to -1
            let assignment = Assignment(title: titleTextField.text!, content: descriptionTextView.text, dueDate: formatter.string(from: date), id: -1, creatorId: creatorId)
            
            delegate?.post(newAssignment: assignment)
            dismiss(animated: true, completion: nil)

        }
    }
}

extension ComposeAssignmentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // When user starts editing, remove the placeholder and change the text color
        if descriptionTextView.textColor == UIColor.textViewColor {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        // When the user ends editing and it's resign as first responder, if the text field is still empty, display the placeholder
        if descriptionTextView.text == "" {
            descriptionTextView.text = "Add description here"
            descriptionTextView.textColor = UIColor.textViewColor
        }
    }
}

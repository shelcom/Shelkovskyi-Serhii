//
//  TaskViewController.swift
//  ToDo List
//
//  Created by Serhii on 26.10.2021.
//

import UIKit

class TaskViewController: BaseViewController {
   
   @IBOutlet var titleTextField: UITextField!
   @IBOutlet var descriptionTextView: UITextView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      titleTextField.delegate = self
      descriptionTextView.delegate = self
      
      let editTextView = UITapGestureRecognizer.init(target: self, action: #selector(editTextView))
      descriptionTextView.isUserInteractionEnabled = true
      descriptionTextView.addGestureRecognizer(editTextView)
   }
}

extension TaskViewController: UITextFieldDelegate, UITextViewDelegate {
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      view.endEditing(true)
      return true
   }
   
   func textViewDidEndEditing(_ textView: UITextView) {
      textView.isEditable = false
   }
   
   @objc func editTextView() {
      descriptionTextView.isEditable = true
      descriptionTextView.becomeFirstResponder()
   }
}

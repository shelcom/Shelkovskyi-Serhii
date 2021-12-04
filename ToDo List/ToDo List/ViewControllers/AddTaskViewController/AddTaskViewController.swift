//
//  AddTaskViewController.swift
//  ToDo List
//
//  Created by Serhii on 04.12.2021.
//

import UIKit

class AddTaskViewController: BaseViewController {

   @IBOutlet weak var descriptionTextView: UITextView!
   @IBOutlet weak var dateTimePicker: UIDatePicker!
   @IBOutlet weak var nameTextField: UITextField!
    
   override func viewDidLoad() {
      super.viewDidLoad()
   }
    
   @IBAction func saveAction(_ sender: Any) {
      let addTaskController = TaskController()
      
      if nameTextField.text!.isEmpty || descriptionTextView.text!.isEmpty {
         let allertCont = UIAlertController(title: "Error", message: "Please enter the Name", preferredStyle: .alert)
         let cancleAction = UIAlertAction(title: "Ok", style: .default)
         
         allertCont.addAction(cancleAction)
         present(allertCont, animated: true, completion: nil)
      } else {
         let _ = addTaskController.add(name: nameTextField.text!, description: descriptionTextView.text!, taskDate: dateTimePicker.date)
         self.navigationController?.popViewController(animated: true)
      }
   }
}

//
//  RegistrationViewController.swift
//  ToDo List
//
//  Created by Serhii on 22.10.2021.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
   @IBOutlet var registrationLable: UILabel!
   @IBOutlet var registrationEmailField: UITextField!
   @IBOutlet var registrationEmailLable: UILabel!
   @IBOutlet var registrationPasswordLable: UILabel!
   @IBOutlet var registrationPasswordField: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.registrationEmailField.delegate = self
      self.registrationPasswordField.delegate = self
   }
   
   //Asks the delegate whether to process the pressing of the Return button for the text field.
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.tagBasedTextField(textField)
      return true
   }
   
   // transition function between field
   private func tagBasedTextField(_ textField: UITextField) {
      switch textField {
      case self.registrationEmailField:
         self.registrationPasswordField.becomeFirstResponder()
      default:
         self.registrationPasswordField.resignFirstResponder() //self.view.endEditing(true)
      }
   }
   
   @IBAction func registrationAction(_ sender: Any) {
   }
}

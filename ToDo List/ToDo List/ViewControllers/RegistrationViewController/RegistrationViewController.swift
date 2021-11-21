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
   
   var resultLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.registrationEmailField.delegate = self
      self.registrationPasswordField.delegate = self
      
      //Init resultLable
      resultLabel = UILabel.init()
      resultLabel.frame = CGRect.init(x: 50, y: 50, width: 50, height: 40)
      resultLabel.textColor = UIColor.red
      view.addSubview(resultLabel)
      
      //Init constraint for resultLabel
      resultLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.init(item: resultLabel!, attribute: .bottom, relatedBy: .equal, toItem: registrationEmailLable, attribute: .top, multiplier: 1, constant: -20).isActive = true
      NSLayoutConstraint.init(item: resultLabel!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20).isActive = true
   }
   
   // hide keyboard (Tells this object that one or more new touches occurred in a view or window.)
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
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
   
   //navigation bar
   override func viewWillAppear(_ animated: Bool) {
      navigationController?.navigationBar.isHidden = false
   }
   
   // pressing the button registrationButton
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      let result = Credentials(email: registrationEmailField.text, password: registrationPasswordField.text).validate()
      fillResaultLable(someText: result.1)
      return result.0
   }
   
   func fillResaultLable(someText: String) {
      self.resultLabel.text = someText
   }
}
      

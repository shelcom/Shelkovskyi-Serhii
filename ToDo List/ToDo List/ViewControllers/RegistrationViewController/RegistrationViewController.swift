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
   
   var resultLable: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.registrationEmailField.delegate = self
      self.registrationPasswordField.delegate = self
      
      //Init resultLable
      resultLable = UILabel.init()
      resultLable.frame = CGRect.init(x:50, y:50, width: 50, height: 40)
      view.addSubview(resultLable)
      resultLable!.textColor = UIColor.red
      
      //Init constraint for resultLabel
      resultLable.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.init(item: resultLable!, attribute: .bottom, relatedBy: .equal, toItem: registrationEmailLable, attribute: .top, multiplier: 1, constant: -20).isActive = true
      NSLayoutConstraint.init(item: resultLable!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20).isActive = true
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
      
      //init Credentials
      let credentials = Credentials()
      credentials.email = registrationEmailField.text
      credentials.password = registrationPasswordField.text
      
      //validate regitration form
      return credentials.validate(label: resultLable!)
   }
}

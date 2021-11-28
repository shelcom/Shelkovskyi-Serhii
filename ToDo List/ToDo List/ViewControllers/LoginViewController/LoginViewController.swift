//
//  LoginViewController.swift
//  ToDo List
//
//  Created by Serhii on 22.10.2021.
//

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {
  
   @IBOutlet var toDoLabel: UILabel!
   @IBOutlet var emailLabel: UILabel!
   @IBOutlet var emailTextField: UITextField!
   @IBOutlet var passwordLabel: UILabel!
   @IBOutlet var passwordTextField: UITextField!
   @IBOutlet var loginButton: UIButton!
   @IBOutlet var registrationButton: UIButton!
   
   var resultLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.emailTextField.delegate = self
      self.passwordTextField.delegate = self
      
      //Init resultLable
      resultLabel = UILabel.init()
      resultLabel.frame = CGRect.init(x: 50, y: 50, width: 50, height: 40)
      resultLabel.textColor = UIColor.red
      view.addSubview(resultLabel)
      
      
      //Init constraint for resultLabel
      resultLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.init(item: resultLabel!, attribute: .bottom, relatedBy: .equal, toItem: emailLabel, attribute: .top, multiplier: 1, constant: -20).isActive = true
      NSLayoutConstraint.init(item: resultLabel!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20).isActive = true
      
      // Rounds a loginButton
      loginButton.layer.cornerRadius = 12
   }
   
   //Asks the delegate whether to process the pressing of the Return button for the text field.
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.tagBasedTextField(textField)
      return true
   }
   
   // transition function between field
   private func tagBasedTextField(_ textField: UITextField) {
      switch textField {
      case self.emailTextField:
         self.passwordTextField.becomeFirstResponder()
      default:
         self.passwordTextField.resignFirstResponder() //self.view.endEditing(true)
      }
   }
   
   //hide navbar
   override func viewWillAppear(_ animated: Bool) {
      navigationController?.navigationBar.isHidden = true
   }
   
   // pressing the button loginButton
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      if identifier != "fromLoginToTaskList" {
         return true
      }

      let credentialController = CredentialsController(credentials: Credentials(email: emailTextField.text,
                                                                                password: passwordTextField.text))
      let result = credentialController.validate()
      
      if result.0 {
         let checkCredentials = credentialController.checkCredentials()
         fillResaultLable(someText: checkCredentials.1)
         return checkCredentials.0
      } else {
         fillResaultLable(someText: result.1)
         return result.0
      }
   }
   
   func fillResaultLable(someText: String) {
      self.resultLabel.text = someText
   }
}

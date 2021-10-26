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
   
   let expectedEmail = "hi@gmail.com"
   let expectedPassword = "12345678"
   var resultLable: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.emailTextField.delegate = self
      self.passwordTextField.delegate = self
      
      //Init resultLable
      resultLable = UILabel.init()
      resultLable.frame = CGRect.init(x:50, y:50, width: 50, height: 40)
      view.addSubview(resultLable)
      resultLable!.textColor = UIColor.red
      
      //Init constraint for resultLabel
      resultLable.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.init(item: resultLable!, attribute: .bottom, relatedBy: .equal, toItem: emailLabel, attribute: .top, multiplier: 1, constant: -20).isActive = true
      NSLayoutConstraint.init(item: resultLable!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20).isActive = true
      
      // Rounds a loginButton
      loginButton.layer.cornerRadius = 12
      print("viewDidLoad")
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
   
   override func viewWillAppear(_ animated: Bool) {
      //hide navbar
      navigationController?.navigationBar.isHidden = true
   }
   
   // pressing the button loginButton
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      
      if identifier != "fromLoginToTaskList" {
         return true
      }
      
      if let email = emailTextField.text,
         let password = passwordTextField.text {
         if email.isEmpty {
            resultLable.text = "Fail: Empty fields"
         } else {
            if email.contains("@") {
               if password.count >= 8 {
                  if email == expectedEmail {
                     if password == expectedPassword {
                        resultLable.text = "Success"
                        return true
                     } else {
                        resultLable.text = "Fail: Wrong password"
                     }
                  } else {
                     resultLable.text = "Fail: Wrong email"
                  }
               } else {
                  resultLable.text = "Fail: Password must be at least 8 symbols"
               }
            } else {
               resultLable.text = "Fail: Wrong email format"
            }
         }
      }
      return false
   }
   
}

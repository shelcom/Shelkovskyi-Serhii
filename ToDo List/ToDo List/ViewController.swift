//
//  ViewController.swift
//  ToDo List
//
//  Created by Serhii on 10.10.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
   @IBOutlet var toDOLabel: UILabel!
   @IBOutlet var emailLabel: UILabel!
   @IBOutlet var emailTextField: UITextField!
   @IBOutlet var passwordLabel: UILabel!
   @IBOutlet var passwordTextField: UITextField!
   @IBOutlet var loginButton: UIButton!
   
   let expectedEmail = "hi@gmail.com"
   let expectedPassword = "12345678"
   var resultLable: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.emailTextField.tag = 0
      self.passwordTextField.tag = 1
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
   
   // hide keyboard
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.tagBasedTextField(textField)
      return true
   }
   
   // transition function between field
   private func tagBasedTextField(_ textField: UITextField) {
      let nextTextFieldTag = textField.tag + 1
      
      if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
         nextTextField.becomeFirstResponder()
      } else {
         textField.resignFirstResponder()
      }
   }
   
   // pressing the button loginButton
   @IBAction func touchLoginButton(_ sender: Any) {
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
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      print("viewWillAppear")
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      print("viewDidAppear")
   }
   
   override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      print("viewDidDisappear")
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      print("viewWillDisappear")
   }
}

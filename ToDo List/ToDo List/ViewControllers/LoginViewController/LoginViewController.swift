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
   let userController = UserController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.emailTextField.delegate = self
      self.passwordTextField.delegate = self
      
      // Rounds a loginButton
      loginButton.layer.cornerRadius = loginButton.layer.frame.height / 2
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
         self.passwordTextField.resignFirstResponder() 
      }
   }
   
   
   @IBAction func loginButton(_ sender: Any) {
      let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
      
      let email = emailTextField.text ?? ""
      let password = passwordTextField.text ?? ""
      
      if email.isEmpty {
         alert(title: "Пустой емайл", message: "Пустой емайл")
      } else {
         if email.contains("@") {
            if password.count >= 8 {
               guard let user = userController.searchUser(currentUserEmail: emailTextField.text ?? "") else { return }
               UserDefaults.standard.setValue(user.id ?? "", forKey: "currentUserId")
               self.navigationController?.pushViewController(vc, animated: true)
            } else {
               alert(title: "Длина пароля", message: "Длина пароля")
            }
         } else {
            alert(title: "Формат емейла", message: "Формат емейла")
         }
      }
   }
   
   //hide navbar
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.isHidden = true
//      resetDefaults()
   }
   
   func resetDefaults() {
       let defaults = UserDefaults.standard
       let dictionary = defaults.dictionaryRepresentation()
       dictionary.keys.forEach { key in
           defaults.removeObject(forKey: key)
       }
   }
}

//
//  LoginViewController.swift
//  ToDo List
//
//  Created by Serhii on 22.10.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
  
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
      
      prepareView()
      
      initDelegate()
   }
   
   func initDelegate() {
      self.emailTextField.delegate = self
      self.passwordTextField.delegate = self
   }
   
   func prepareView() {
      self.view.backgroundColor = UIColor(patternImage: UIImage(named: "loggin.png")!)
      
      loginButton.layer.cornerRadius = loginButton.layer.frame.height / 2
      registrationButton.layer.cornerRadius = loginButton.layer.frame.height / 2
      
      let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tapGesture)
   }
   
   @objc func hideKeyboard() {
      view.endEditing(true)
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.tagBasedTextField(textField)
      return true
   }
   
   private func tagBasedTextField(_ textField: UITextField) {
      switch textField {
      case self.emailTextField:
         self.passwordTextField.becomeFirstResponder()
      default:
         self.passwordTextField.resignFirstResponder() 
      }
   }
   
   @IBAction func loginButton(_ sender: Any) {
      let email = emailTextField.text ?? ""
      let password = passwordTextField.text ?? ""
      
      login(email: email, password: password)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.isHidden = true
   }
}

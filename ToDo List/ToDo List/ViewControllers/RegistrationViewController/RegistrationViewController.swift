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
   @IBOutlet var registrationButton: UIButton!
   
   var resultLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
     
      prepareView()
      initDelegate()
   }
   
   func initDelegate() {
      self.registrationEmailField.delegate = self
      self.registrationPasswordField.delegate = self
   }
   
   func prepareView() {
      self.view.backgroundColor = UIColor(patternImage: UIImage(named: "loggin.png")!)
      registrationButton.layer.cornerRadius = registrationButton.layer.frame.height / 2
      
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
      case self.registrationEmailField:
         self.registrationPasswordField.becomeFirstResponder()
      default:
         self.registrationPasswordField.resignFirstResponder()
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      navigationController?.navigationBar.isHidden = false
   }
   
   @IBAction func registerButton(_ sender: Any) {
      let email = registrationEmailField.text ?? ""
      let password = registrationPasswordField.text ?? ""
      
      registration(email: email, password: password)
   }
}

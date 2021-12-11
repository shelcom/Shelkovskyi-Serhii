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
   let userController = UserController()
   let noteController = NoteController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //Init delegate
      self.registrationEmailField.delegate = self
      self.registrationPasswordField.delegate = self
      
      let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tapGesture)
      
      registrationButton.layer.cornerRadius = registrationButton.layer.frame.height / 2
   }
   
   @objc func hideKeyboard() {
      view.endEditing(true)
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
   
   @IBAction func registerButton(_ sender: Any) {
      let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
      
      let email = registrationEmailField.text ?? ""
      let password = registrationPasswordField.text ?? ""
      
      if email.isEmpty {
         alert(title: "Пустой емайл", message: "Пустой емайл")
      } else {
         if email.contains("@") {
            if password.count >= 8 {
               guard let user = userController.add(email: email, password: password) else { return }
               UserDefaults.standard.setValue(user.id ?? "", forKey: "currentUserId")
               noteController.addTestNotes(userId: user.id ?? 0)
               self.navigationController?.pushViewController(vc, animated: true)
            } else {
               alert(title: "Длина пароля", message: "Длина пароля")
            }
         } else {
            alert(title: "Формат емейла", message: "Формат емейла")
         }
      }
   }
}

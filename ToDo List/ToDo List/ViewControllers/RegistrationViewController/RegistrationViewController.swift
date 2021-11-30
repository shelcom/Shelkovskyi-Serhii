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
   
   // pressing the button registrationButton
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      let credentialController = CredentialsController(credentials: Credentials(email:registrationEmailField.text,
                                                                                password:registrationPasswordField.text))
      do {
         try credentialController.validate()
         return true
      } catch {
         resultLabel.text = (error as! CredentialsError).description
         return false
      }
   }
}

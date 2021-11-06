//
//  Credentials.swift
//  ToDo List
//
//  Created by Serhii on 28.10.2021.
//

import Foundation
import UIKit

class Credentials: CredentialsInterface {
   
   var email: String?
   var password: String?
   
   init(email: String?, password: String?) {
      self.email = email
      self.password = password
   }
   
   //Validate email and password
   func validate(label: UILabel!) -> Bool {
      if let email = self.email,
         let password = self.password {
         if email.isEmpty {
            label.text = "Fail: Empty fields"
         } else {
            if email.contains("@") {
               if password.count >= 8 {
                  label.text = "Success"
                  return true
               } else {
                  label.text = "Fail: Password must be at least 8 symbols"
               }
            } else {
               label.text = "Fail: Wrong email format"
            }
         }
      }
      return false
   }
}

class LoginCredentials: Credentials {
   private var expectedEmail: String?
   private var expectedPassword: String?
   
   override init(email: String?, password: String?) {
      self.expectedEmail = "hi@gmail.com"
      self.expectedPassword = "12345678"
      
      super.init(email: email, password: password)
   }
   
   //Validate user account email and password
   override func validate(label: UILabel!) -> Bool {
      let isValid = super.validate(label: label)
      
      if isValid {
         if self.email == expectedEmail {
            if self.password == expectedPassword {
               return true
            } else {
               label.text = "Fail: Wrong password"
            }
         } else {
            label.text = "Fail: Wrong email address"
         }
      }
      return false
   }
}

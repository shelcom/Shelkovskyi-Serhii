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
   
   let expectedEmail: String = "hi@gmail.com"
   let expectedPassword: String = "12345678"
   
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
      // return isValid ?
      //    (self.email == expectedEmail && self.password == expectedPassword) : false
   }
}

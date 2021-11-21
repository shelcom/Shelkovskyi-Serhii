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
   func validate() -> (Bool, String) {
      if let email = self.email,
         let password = self.password {
         if email.isEmpty {
         } else {
            if email.contains("@") {
               if password.count >= 8 {
                  return (true, "Success")
               } else {
                  return (false, "Fail: Password must be at least 8 symbols")
               }
            } else {
               return (false, "Fail: Wrong email format")
            }
         }
      }
      return (false, "Fail: Please enter the data")
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
   override func validate() -> (Bool, String) {
      let isValid = super.validate()
      
      if isValid.0 {
         if self.email == expectedEmail {
            if self.password == expectedPassword {
               return (true, "Good")
            } else {
               return (false, "Fail: Wrong password")
            }
         } else {
            return (false, "Fail: Wrong email address")
         }
      }
      return (false, isValid.1)
   }
}

//
//  CredentialsController.swift
//  ToDo List
//
//  Created by Serhii on 26.11.2021.
//

import Foundation

class CredentialsController {
   
   var credentials: Credentials
   let expectedCredentials: Credentials = Credentials.init(email: "hi@gmail.com", password: "12345678")
   
   init(credentials: Credentials) {
      self.credentials = credentials
   }
   
   //Validate email and password
   func validate() -> (Bool, String) {
      if let email = credentials.email,
         let password = credentials.password {
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
   
   func checkCredentials() -> (Bool, String) {
      if credentials.email == expectedCredentials.email {
         if credentials.password == credentials.password {
            return (true, "Success")
         } else {
            return (false, "Fail: Wrong passeord")
         }
      } else {
         return (false, "Fail: Wrong email addess")
      }
   }
}

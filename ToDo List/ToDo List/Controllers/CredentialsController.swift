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
   func validate() throws {
      if let email = credentials.email,
         let password = credentials.password {
         if email.isEmpty {
            throw CredentialsError.emptyFields
         } else {
            if email.contains("@") {
               if password.count >= 8 {
                  print("Success")
               } else {
                  throw CredentialsError.wrongPasswordFormat
               }
            } else {
               throw CredentialsError.wrongEmailFormat
            }
         }
      }
   }
   
   func checkCredentials() throws {
      if credentials.email == expectedCredentials.email {
         if credentials.password == expectedCredentials.password {
            print("Success")
         } else {
            throw CredentialsError.wrongPassword
         }
      } else {
         throw CredentialsError.wrongEmail
      }
   }
}

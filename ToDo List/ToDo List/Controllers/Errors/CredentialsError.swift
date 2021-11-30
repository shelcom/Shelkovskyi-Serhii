//
//  CredentialsError.swift
//  ToDo List
//
//  Created by Serhii on 30.11.2021.
//

import Foundation

enum CredentialsError: Error {
   case wrongPasswordFormat
   case wrongEmailFormat
   case emptyFields
   case wrongPassword
   case wrongEmail
   
   var description: String {
      switch self {
      case .wrongPasswordFormat:
         return "Fail: Password must be at least 8 symbols"
      case .wrongEmailFormat:
         return "Fail: Wrong email format"
      case .emptyFields:
         return "Fail: Please enter the data"
      case .wrongPassword:
         return "Fail: Wrong password"
      case .wrongEmail:
         return "Fail: Wrong email address"
      }
   }
}

//
//  UserController.swift
//  ToDo List
//
//  Created by Serhii on 06.12.2021.
//

import Foundation

class UserController {
   
   let defaults = UserDefaults.standard
   
   private var users: [User] {
      get {
         if let data = defaults.value(forKey: "users") as? Data {
            return try! PropertyListDecoder().decode([User].self, from: data)
         } else {
            return [User]()
         }
      }
      set {
         guard let data = try? PropertyListEncoder().encode(newValue) else { return }
         defaults.set(data, forKey: "users")
      }
   }
   
   func add(email: String, password: String) -> User? {
      let newUser = User.init(id: setId(), email: email, password: password)
      users.append(newUser)
      return newUser
   }
   
   func setId() -> Int {
      users.isEmpty ? 1 : (users.last?.id ?? 0) + 1
   }
   
   func searchUser(currentUserEmail: String) -> User? {
      let user = users.filter { user in
         user.email == currentUserEmail
      }
      let firstUser = user.first
      return firstUser ?? nil
   }
}

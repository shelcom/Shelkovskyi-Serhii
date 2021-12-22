//
//  Authentification + Extrnsion.swift
//  ToDo List
//
//  Created by Serhii on 22.12.2021.
//

import Foundation
import UIKit

extension UIViewController {
   
   func login(email: String, password: String) {
      let userController = UserController()
      let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
      
      if email.isEmpty {
         alert(title: "Error", message: "Email is empty")
      } else {
         if email.contains("@") {
            if password.count >= 8 {
               if userController.checkUserEmail(email: email) {
                  alert(title: "Error", message: "This email don't registration")
               } else {
                  if userController.checkUserPassword(email: email, password: password) {
                     guard let user = userController.searchUser(currentUserEmail: email) else { return }
                     UserDefaults.standard.setValue(user.id ?? "", forKey: "currentUserId")
                     self.navigationController?.pushViewController(vc, animated: true)
                  } else {
                     alert(title: "Error", message: "This password don't correctly")
                  }
               }
            } else {
               alert(title: "Error", message: "Password must be at least 8 characters long")
            }
         } else {
            alert(title: "Error", message: "Wrong email format")
         }
      }
   }
   
   func registration(email: String, password: String) {
      let userController = UserController()
      let noteController = NoteController()
      let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
      
      if email.isEmpty {
         alert(title: "Error", message: "Email is empty")
      } else {
         if email.contains("@") {
            if password.count >= 8 {
               if userController.checkUserEmail(email: email) {
                  guard let user = userController.add(email: email, password: password) else { return }
                  UserDefaults.standard.setValue(user.id ?? "", forKey: "currentUserId")
                  noteController.addTestNotes(userId: user.id ?? 0)
                  self.navigationController?.pushViewController(vc, animated: true)
               } else {
                  alert(title: "Error", message: "This email is busy")
               }
            } else {
               alert(title: "Error", message: "Password must be at least 8 characters long")
            }
         } else {
            alert(title: "Error", message: "Wrong email format")
         }
      }
   }
}

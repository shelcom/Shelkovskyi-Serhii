//
//  UserController.swift
//  ToDo List
//
//  Created by Serhii on 20.11.2021.
//

import Foundation

class UserController {
   
   private var users: [UserModel] = []
   
   func addNewUser(name: String?, contactNumber: String?, currentWeight: Int?, currentLength: Int?, calories: Int?, choosePlan: String?, period: Int?) -> UserModel? {
      let newUser = UserModel.init(name: name, contactNumber: contactNumber, currentWeight: currentWeight, currentLength: currentLength, calories: calories, choosePlan: choosePlan, period: period)
      return newUser
   }
}

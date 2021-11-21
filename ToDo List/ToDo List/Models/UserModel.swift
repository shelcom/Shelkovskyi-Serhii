//
//  UserModel.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import Foundation

class UserModel {
   var name: String?
   var contactNumber: String?
   var currentWeight: Int?
   var currentLength: Int?
   var calories: Int?
   var choosePlan: String?
   var period: Int?
   var currentPlan: PlanModel?
    
   init(name: String?, contactNumber: String?, currentWeight: Int?, currentLength: Int?, calories: Int?, choosePlan: String?, period: Int?) {
      self.name = name
      self.contactNumber = contactNumber
      self.currentLength = currentLength
      self.currentWeight = currentWeight
      self.calories = calories
      self.choosePlan = choosePlan
      self.period = period
   }
}

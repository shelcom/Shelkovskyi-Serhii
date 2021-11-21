//
//  UserManager.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import Foundation

class UserManager {
   static let shared = UserManager()
    
   var user: UserModel?
   var planController = PlanController()
    
   func choosePlans(user: UserModel?) {
      if user != nil {
         switch user!.choosePlan {
            case "getWeightPlan":
               user!.currentPlan = planController.createGetWeightPlanPlan()
            case "loseWeightPlan":
               user!.currentPlan = planController.createLoseWeightPlan()
            case "maintainingWeightPlan":
               user!.currentPlan = planController.createMaintainingWeightPlan()
            default:
               break
         }
      } else {
         return
      }
   }
}

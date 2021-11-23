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
            case 0:
               user!.currentPlan = planController.createGetWeightPlanPlan()
            case 1:
               user!.currentPlan = planController.createLoseWeightPlan()
            case 2:
               user!.currentPlan = planController.createMaintainingWeightPlan()
            default:
               break
         }
      } else {
         return
      }
   }
}

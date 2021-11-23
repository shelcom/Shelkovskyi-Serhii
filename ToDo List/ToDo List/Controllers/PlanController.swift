//
//  PlanController.swift
//  ToDo List
//
//  Created by Serhii on 20.11.2021.
//

import Foundation

class PlanController {
   
   private var plan: PlanModel?
   var products: [ProductModel] = []
   var productController = ProductController()
   
   func createGetWeightPlanPlan() -> PlanModel {
      let getWeightPlan: PlanModel = PlanModel.init(expectedCallories: 3200)
      getWeightPlan.products = productController.getWeightPlanProduct()
      return getWeightPlan
   }
   
   func createLoseWeightPlan() -> PlanModel {
      let loseWeightPlan: PlanModel = PlanModel.init(expectedCallories: 1200)
      loseWeightPlan.products = productController.loseWeightPlanProduct()
      return loseWeightPlan
   }
   
   func createMaintainingWeightPlan() -> PlanModel {
      let maintainingWeightPlan: PlanModel = PlanModel.init(expectedCallories: 2200)
      maintainingWeightPlan.products = productController.maintainingWeightPlanProduct()
      return maintainingWeightPlan
   }
}

//
//  PlanModel.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import Foundation

class PlanModel {
   
   var products: [ProductModel] = []
   var expectedCallories: Int
    
   init(expectedCallories: Int) {
      self.expectedCallories = expectedCallories
   }
}

//
//  ProductModel.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import Foundation

class ProductModel: Codable {
   
   var name: String?
   var calories: Int?
   var weight: String?
   var count: String?
    
   init(name: String?, calories: Int?, weight: String?, count: String?) {
      self.name = name
      self.calories = calories
      self.weight = weight
      self.count = count
   }
}

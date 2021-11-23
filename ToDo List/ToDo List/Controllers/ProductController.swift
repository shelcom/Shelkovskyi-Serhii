//
//  ProductController.swift
//  ToDo List
//
//  Created by Serhii on 20.11.2021.
//

import Foundation

class ProductController {
   
   private var products: [ProductModel] = [ProductModel.init(name: "BigMac", calories: 1000, weight: "300", count: "1"),
                                           ProductModel.init(name: "Soup", calories: 500, weight: "300", count: "1"),
                                           ProductModel.init(name: "Lemon", calories: 100, weight: "300", count: "1"),
                                           ProductModel.init(name: "Bread", calories: 200, weight: "300", count: "1"),
                                           ProductModel.init(name: "Cherry", calories: 200, weight: "300", count: "1"),
                                           ProductModel.init(name: "Steak", calories: 1200, weight: "300", count: "1"),
                                           ProductModel.init(name: "Soup", calories: 800, weight: "300", count: "1"),
                                           ProductModel.init(name: "Salad", calories: 400, weight: "300", count: "1"),
                                           ProductModel.init(name: "Fish", calories: 400, weight: "300", count: "1"),
                                           ProductModel.init(name: "Rice", calories: 400, weight: "300", count: "1"),
                                           ProductModel.init(name: "Pizza", calories: 1000, weight: "300", count: "1"),
                                           ProductModel.init(name: "Eggs", calories: 800, weight: "300", count: "1"),]
   
   func product(by index: Int) -> ProductModel {
      products[index]
   }
   
   func productsCount() -> Int {
      products.count
   }
   
   func getWeightPlanProduct() -> [ProductModel] {
      [ProductModel.init(name: "BigMac", calories: 1000, weight: "300", count: "1"),
       ProductModel.init(name: "Pizza", calories: 1000, weight: "300", count: "1"),
       ProductModel.init(name: "Steak", calories: 1200, weight: "300", count: "1")]
   }
   
   func loseWeightPlanProduct() -> [ProductModel] {
      [ProductModel.init(name: "Salad", calories: 400, weight: "300", count: "1"),
       ProductModel.init(name: "Rice", calories: 400, weight: "300", count: "1"),
       ProductModel.init(name: "Fish", calories: 400, weight: "300", count: "1")]
   }
   
   func maintainingWeightPlanProduct() -> [ProductModel] {
      [ProductModel.init(name: "BigMac", calories: 1000, weight: "300", count: "1"),
       ProductModel.init(name: "Soup", calories: 800, weight: "300", count: "1"),
       ProductModel.init(name: "Fish", calories: 400, weight: "300", count: "1")]
   }
}

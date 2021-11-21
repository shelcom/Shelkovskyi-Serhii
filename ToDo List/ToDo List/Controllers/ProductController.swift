//
//  ProductController.swift
//  ToDo List
//
//  Created by Serhii on 20.11.2021.
//

import Foundation

class ProductController {
   
   private var products: [ProductModel]? = []
   
   func chooseEatenProduct(firstProduct: [String]?, secondProduct: [String]?, thirdProduct: [String]?) -> [ProductModel]? {
      if firstProduct!.count > 0 {
         products!.append(ProductModel.init(name: firstProduct![0], calories: 800, weight: "300", count: firstProduct![1]))
      }
      
      if secondProduct!.count > 0 {
         products!.append(ProductModel.init(name: secondProduct![0], calories: 300, weight: "300", count: secondProduct![1]))
      }
      
      if thirdProduct!.count > 0 {
         products!.append(ProductModel.init(name: thirdProduct![0], calories: 200, weight: "300", count: thirdProduct![1]))
      }
      
      return products!
   }
   
   func getWeightPlanProduct() -> [ProductModel] {
      [ProductModel.init(name: "BigMac", calories: 800, weight: "300", count: "1"),
       ProductModel.init(name: "BigMac", calories: 800, weight: "300", count: "1"),
       ProductModel.init(name: "BigMac", calories: 800, weight: "300", count: "1")]
   }
   
   func loseWeightPlanProduct() -> [ProductModel] {
      [ProductModel.init(name: "Banana", calories: 300, weight: "300", count: "1"),
       ProductModel.init(name: "Banana", calories: 300, weight: "300", count: "1"),
       ProductModel.init(name: "Banana", calories: 300, weight: "300", count: "1")]
   }
   
   func maintainingWeightPlanProduct() -> [ProductModel] {
      [ProductModel.init(name: "BigMac", calories: 800, weight: "300", count: "1"),
       ProductModel.init(name: "BigMac", calories: 800, weight: "300", count: "1"),
       ProductModel.init(name: "Banana", calories: 300, weight: "300", count: "1")]
   }
   
}

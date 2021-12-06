//
//  ProductController.swift
//  ToDo List
//
//  Created by Serhii on 20.11.2021.
//

import Foundation

class ProductController {
   
   let defaults = UserDefaults.standard
   
   private var products: [ProductModel] {
      get {
         if let data = defaults.value(forKey: "products") as? Data {
            return try! PropertyListDecoder().decode([ProductModel].self, from: data)
         } else {
            return [ProductModel]()
         }
      }
      set {
         guard let data = try? PropertyListEncoder().encode(newValue) else { return }
         defaults.set(data, forKey: "products")
      }
   }

   func initNewProduct(name: String, calories: Int, weight: String, count: String) {
      let product = ProductModel.init(name: name, calories: calories, weight: weight, count: count)
      products.append(product)
   }
   
   func add(product: ProductModel) {
      products.append(product)
   }
   
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

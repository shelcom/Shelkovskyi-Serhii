//
//  HomeScreenViewController.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import UIKit

class HomeScreenViewController: UIViewController {
   
   @IBOutlet var foodTableView: UITableView!
   @IBOutlet var planTableView: UITableView!
   @IBOutlet var totalCalLabel: UILabel!
   @IBOutlet var sliderCalValue: UILabel!
   @IBOutlet var caloriesSlider: UISlider!
   @IBOutlet var maxCalLabel: UILabel!
   
   var plan: PlanModel?
   var newProducts: [ProductModel]?
   var allProducts: [ProductModel]?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      foodTableView.delegate = self
      foodTableView.dataSource = self
      foodTableView.register(UINib.init(nibName: "EatenFoodTableViewCell", bundle: nil), forCellReuseIdentifier: "EatenFoodCell")
      
      planTableView.delegate = self
      planTableView.dataSource = self
      planTableView.register(UINib.init(nibName: "PlanTableViewCell", bundle: nil), forCellReuseIdentifier: "PlanCell")
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? AddDishesViewController {
         vc.competion = { (text) in
            self.newProducts = text
            if self.newProducts!.count > 0 {
               self.checkProducts()
               self.checktotalCal()
               self.foodTableView.reloadData()
            }
         }
      }
   }
   
   func checkProducts() {
      allProducts?.count == nil ? allProducts = newProducts : checkCountNewProducs()
   }
   
   func checkCountNewProducs() {
      if newProducts!.count == 2 {
         allProducts!.append(newProducts![0])
         allProducts!.append(newProducts![1])
      } else if newProducts!.count == 1 {
         allProducts!.append(newProducts![0])
      } else {
         allProducts!.append(newProducts![0])
         allProducts!.append(newProducts![1])
         allProducts!.append(newProducts![2])
      }
   }
   
   func checktotalCal() {
      let allCal = allProducts!.map { item in
         item.count!.isEmpty ? 0 : item.calories! * Int(item.count!)!
      }.reduce(0, +)
      totalCalLabel.text!  = "\(allCal)"
      sliderCalValue.text! = totalCalLabel.text!
      caloriesSlider.setValue(Float(allCal), animated: true)
      
   }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if tableView == foodTableView {
         guard self.allProducts != nil else { return 0 }
         return self.allProducts!.count
      } else {
         guard plan != nil else { return 0 }
         return plan!.products.count
      }
   }
     
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if tableView == foodTableView,
         let cell = foodTableView.dequeueReusableCell(withIdentifier: "EatenFoodCell") as? EatenFoodTableViewCell {
         if allProducts!.count > 0 {
            cell.fill(with: allProducts![indexPath.row])
         }
         return cell
      } else if tableView == planTableView,
         let cell = planTableView.dequeueReusableCell(withIdentifier: "PlanCell") as? PlanTableViewCell {
         cell.fill(with: plan!.products[indexPath.row])
         maxCalLabel.text! = String(plan!.expectedCallories)
         return cell
      }
      return UITableViewCell()
   }
}

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
   @IBOutlet var totalCaloriesLabel: UILabel!
   @IBOutlet var sliderCaloriesValue: UILabel!
   @IBOutlet var caloriesSlider: UISlider!
   @IBOutlet var caloriesPerDayLabel: UILabel!
   @IBOutlet var addFoodButton: UIButton!
   
   var plan: PlanModel?
   var newProduct: ProductModel?
   var allProducts: [ProductModel] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhoto")!)
      addFoodButton.layer.cornerRadius = addFoodButton.layer.frame.height / 2
      
      prepareTableView()
   }
   
   func prepareTableView() {
      foodTableView.delegate = self
      foodTableView.dataSource = self
      foodTableView.register(UINib.init(nibName: "EatenFoodTableViewCell", bundle: nil), forCellReuseIdentifier: "EatenFoodCell")
      
      planTableView.delegate = self
      planTableView.dataSource = self
      planTableView.register(UINib.init(nibName: "EatenFoodTableViewCell", bundle: nil), forCellReuseIdentifier: "EatenFoodCell")
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? AddDishesViewController {
         vc.competion = { (text) in
            self.newProduct = text
            if self.newProduct != nil {
               self.addNewProductsToAllProducts()
               self.checkTotalCal()
               self.foodTableView.reloadData()
            }
         }
      }
   }
   
   func addNewProductsToAllProducts() {
      if newProduct != nil {
         allProducts.append(newProduct!)
      }
   }
   
   func checkTotalCal() {
      let allCal = allProducts.map { item in
         item.count!.isEmpty ? 0 : item.calories! * Int(item.count!)!
      }.reduce(0, +)
      totalCaloriesLabel.text! = "Total Cal. \(allCal)"
      sliderCaloriesValue.text! = "\(allCal) Current Cal."
      caloriesSlider.setValue(Float(allCal), animated: true)
   }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if tableView == foodTableView {
         return allProducts.count
      } else {
         guard plan != nil else { return 0 }
         return plan!.products.count
      }
   }
     
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if tableView == foodTableView,
         let cell = foodTableView.dequeueReusableCell(withIdentifier: "EatenFoodCell") as? EatenFoodTableViewCell {
         if allProducts.count > 0 {
            cell.fill(with: allProducts[indexPath.row])
         }
         return cell
      } else if tableView == planTableView,
         let cell = planTableView.dequeueReusableCell(withIdentifier: "EatenFoodCell") as? EatenFoodTableViewCell {
         cell.fill(with: plan!.products[indexPath.row])
         return cell
      }
      return UITableViewCell()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      caloriesPerDayLabel.text = "Сalories Per Day (Max. \(plan!.expectedCallories) Cal)"
   }
}

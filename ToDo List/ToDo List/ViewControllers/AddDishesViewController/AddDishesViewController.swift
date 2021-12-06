//
//  AddDishesViewController.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import UIKit

class AddDishesViewController: UIViewController {
   
   @IBOutlet var addFoodTable: UITableView!
   @IBOutlet var addFoodButton: UIButton!
   
   let productController = ProductController()
   var competion: ((ProductModel?) -> ())?
   var competionNewProduct: (() -> ())?
   var chooseProduct: ProductModel?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      addFoodButton.layer.cornerRadius = addFoodButton.layer.frame.height / 2
      
      prepareTableView()
   }
   
   func prepareTableView() {
      addFoodTable.delegate = self
      addFoodTable.dataSource = self
      addFoodTable.register(UINib.init(nibName: "EatenFoodTableViewCell", bundle: nil), forCellReuseIdentifier: "EatenFoodCell")
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? AddNewDishesViewController {
         vc.competionNewProduct = {
            self.addFoodTable.reloadData()
         }
      }
   }
   
   @IBAction func closeAction(_ sender: Any) {
      competion?(chooseProduct)
      self.navigationController?.popViewController(animated: true)
   }
}

extension AddDishesViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return productController.productsCount()
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if tableView == addFoodTable,
         let cell = addFoodTable.dequeueReusableCell(withIdentifier: "EatenFoodCell") as? EatenFoodTableViewCell {
         if productController.productsCount() > 0 {
            cell.fill(with: productController.product(by: indexPath.row))
         }
         return cell
      }
      
      return UITableViewCell()
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      chooseProduct = productController.product(by: indexPath.row)
   }
}

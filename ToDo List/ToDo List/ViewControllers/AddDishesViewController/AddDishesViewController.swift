//
//  AddDishesViewController.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import UIKit

class AddDishesViewController: UIViewController {
   
   @IBOutlet var firstFoodSwitch: UISwitch!
   @IBOutlet var secondFoodSwitch: UISwitch!
   @IBOutlet var thirdFoodSwitch: UISwitch!
   @IBOutlet var firstCountTextField: UITextField!
   @IBOutlet var secondCountTextField: UITextField!
   @IBOutlet var thirdCountTextField: UITextField!
   @IBOutlet var firstNameLabel: UILabel!
   @IBOutlet var secondNameLabel: UILabel!
   @IBOutlet var thirdNameLabel: UILabel!
   
   let productController = ProductController()
   var competion: (([ProductModel]?) -> ())?
   var firstProduct: [String]? = []
   var secondProduct: [String]? = []
   var thirdProduct: [String]? = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   func checkFirstEatenProduct() {
      firstFoodSwitch.isOn ? firstProduct!.append(contentsOf: [firstNameLabel.text!, firstCountTextField!.text!]) : nil
   }
   
   func checkSecondEatenProduct() {
      secondFoodSwitch.isOn ? secondProduct!.append(contentsOf: [secondNameLabel.text!, secondCountTextField!.text!]) : nil
   }
   
   func checkThirdEatenProduct() {
      thirdFoodSwitch.isOn ? thirdProduct!.append(contentsOf: [thirdNameLabel.text!, thirdCountTextField!.text!]) : nil
   }
   
   @IBAction func closeAction(_ sender: Any) {
      checkFirstEatenProduct()
      checkSecondEatenProduct()
      checkThirdEatenProduct()
      competion?(productController.chooseEatenProduct(firstProduct: firstProduct, secondProduct: secondProduct, thirdProduct: thirdProduct))
      self.dismiss(animated: true, completion: nil)
   }
}

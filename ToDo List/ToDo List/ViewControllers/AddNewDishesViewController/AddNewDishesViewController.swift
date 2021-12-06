//
//  AddNewDishesViewController.swift
//  Fitness App
//
//  Created by Serhii on 30.11.2021.
//

import UIKit

class AddNewDishesViewController: UIViewController {
   
   @IBOutlet var nameProductTextField: UITextField!
   @IBOutlet var caloriesProductTextField: UITextField!
   @IBOutlet var weightProductTextField: UITextField!
   @IBOutlet var countProductTextField: UITextField!
   @IBOutlet var addNewFoodButton: UIButton!
   
   var competionNewProduct: (() -> ())?
   var newProduct: ProductModel?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      prepareView()
   }
   
   func prepareView() {
      addNewFoodButton.layer.cornerRadius = addNewFoodButton.layer.frame.height / 2
      
      nameProductTextField.delegate = self
      caloriesProductTextField.delegate = self
      weightProductTextField.delegate = self
      countProductTextField.delegate = self
      
      let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tapGesture)
   }
   
   @IBAction func addNewFood(_ sender: Any) {
      createNewDishes()
      competionNewProduct?()
      self.dismiss(animated: true, completion: nil)
   }
   
   func createNewDishes() {
      let productController = ProductController()
      
      if nameProductTextField.text!.isEmpty || caloriesProductTextField.text!.isEmpty || weightProductTextField.text!.isEmpty || countProductTextField.text!.isEmpty {
         let allertCont = UIAlertController(title: "Error", message: "Please enter the Name", preferredStyle: .alert)
         let cancleAction = UIAlertAction(title: "Ok", style: .default)
         allertCont.addAction(cancleAction)
         present(allertCont, animated: true, completion: nil)
      } else {
         productController.initNewProduct(name: nameProductTextField.text!,
                                          calories: Int(caloriesProductTextField.text!)!,
                                          weight: weightProductTextField.text!,
                                          count: countProductTextField.text!)
         }
      }
   }

extension AddNewDishesViewController: UITextFieldDelegate {
   
   @objc func hideKeyboard() {
      view.endEditing(true)
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.tagBasedTextField(textField)
      return true
   }
   
   private func tagBasedTextField(_ textField: UITextField) {
      switch textField {
         case self.nameProductTextField:
            self.caloriesProductTextField.becomeFirstResponder()
         case self.caloriesProductTextField:
            self.weightProductTextField.becomeFirstResponder()
         case self.weightProductTextField:
            self.countProductTextField.becomeFirstResponder()
         default:
            self.view.endEditing(true)
      }
   }
}

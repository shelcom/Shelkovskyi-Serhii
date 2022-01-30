//
//  FactorySecondViewController.swift
//  ToDoList
//
//  Created by Serhii on 30.01.2022.
//

import UIKit

class FactorySecondViewController: UIViewController {
   
   @IBOutlet var titleLabel: UILabel!
   
   var startCooking = StartCooking()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   @IBAction func clickSoup(_ sender: Any) {
      titleLabel.text = startCooking.cookDish(dish: Soup())
   }
   
   @IBAction func clickPorridge(_ sender: Any) {
      titleLabel.text = startCooking.cookDish(dish: Porridge())
   }
}

//
//  BuilderFirstViewController.swift
//  ToDoList
//
//  Created by Serhii on 31.01.2022.
//

import UIKit

class BuilderFirstViewController: UIViewController {

   @IBOutlet var titleLabel: UILabel!
   
   var parka = Jacket(parka: Parka())
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      createParka()
   }
   
   func createParka() {
      let createParka = parka.addHood().addLock().addPocket(countPocket: 4).finish()
      titleLabel.text = "Parka have: hood - \(createParka.hood ?? false), lock - \(createParka.lock ?? false), pocket - \(createParka.pocket ?? 0)"
   }
}

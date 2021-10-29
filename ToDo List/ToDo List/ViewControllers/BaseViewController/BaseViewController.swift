//
//  BaseViewController.swift
//  ToDo List
//
//  Created by Serhii on 22.10.2021.
//

import UIKit

class BaseViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.backgroundColor = .orange
   }
   
   // hide keyboard (Tells this object that one or more new touches occurred in a view or window.)
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
}

//
//  TabBarViewController.swift
//  ToDo List
//
//  Created by Serhii on 07.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.isHidden = true
   }
}

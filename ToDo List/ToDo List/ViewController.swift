//
//  ViewController.swift
//  ToDo List
//
//  Created by Serhii on 10.10.2021.
//

import UIKit

class ViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      print("viewDidLoad")
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      print("viewWillAppear")
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      print("viewDidAppear")
   }
   
   override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      print("viewDidDisappear")
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      print("viewWillDisappear")
   }


}


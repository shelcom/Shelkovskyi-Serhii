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
      
      let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tapGesture)
   }
   
   @objc func hideKeyboard() {
      view.endEditing(true)
   }
}

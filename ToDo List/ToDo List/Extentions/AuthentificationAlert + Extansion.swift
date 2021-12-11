//
//  AuthentificationAlert + Extansion.swift
//  ToDo List
//
//  Created by Serhii on 06.12.2021.
//

import Foundation
import UIKit

extension UIViewController {
   
   func alert(title: String, message: String) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let cancleAction = UIAlertAction(title: "Ok", style: .default)
      
      alert.addAction(cancleAction)
      present(alert, animated: true, completion: nil)
   }
}

//
//  UIImageViewExtansion.swift
//  ToDoList
//
//  Created by Serhii on 26.01.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
   func setImage(imageUrl: String) {
      self.kf.setImage(with: URL(string: imageUrl))
   }
}

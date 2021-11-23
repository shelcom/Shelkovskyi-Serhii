//
//  EatenFoodTableViewCell.swift
//  ToDo List
//
//  Created by Serhii on 21.11.2021.
//

import UIKit

class EatenFoodTableViewCell: UITableViewCell {

   @IBOutlet var nameLabel: UILabel!
   @IBOutlet var caloriesLabel: UILabel!
      
   override func awakeFromNib() {
      super.awakeFromNib()
   }
      
   func fill(with model: ProductModel?) {
      nameLabel.text = model!.name
      caloriesLabel.text = "\(model!.calories!)"
   }
}

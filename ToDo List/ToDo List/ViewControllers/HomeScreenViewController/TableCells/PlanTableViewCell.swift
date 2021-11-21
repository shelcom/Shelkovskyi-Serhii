//
//  PlanTableViewCell.swift
//  ToDo List
//
//  Created by Serhii on 20.11.2021.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
   
   @IBOutlet var nameLabel: UILabel!
   @IBOutlet var countLabel: UILabel!
   @IBOutlet var caloriesLabel: UILabel!
   
    override func awakeFromNib() {
       super.awakeFromNib()
    }

   func fill(with model: ProductModel?) {
      nameLabel.text = model!.name
      countLabel.text = model!.count
      caloriesLabel.text = "\(model!.calories!)"
   }
    
}

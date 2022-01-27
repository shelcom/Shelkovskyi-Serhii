//
//  FirstGemaCell.swift
//  ToDoList
//
//  Created by Serhii on 24.01.2022.
//

import UIKit

class FirstGemaCell: UITableViewCell {

   @IBOutlet var priceButton: UIButton!
   @IBOutlet var gameImage: UIImageView!
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var descriptionLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      priceButton.layer.cornerRadius = 12
   }
}

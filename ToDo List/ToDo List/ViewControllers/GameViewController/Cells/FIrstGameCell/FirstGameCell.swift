//
//  FirstGemaCell.swift
//  ToDoList
//
//  Created by Serhii on 24.01.2022.
//

import UIKit

class FirstGameCell: UITableViewCell {

   @IBOutlet var priceButton: UIButton!
   @IBOutlet var gameImage: UIImageView!
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var descriptionLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      priceButton.layer.cornerRadius = 12
   }
   
   func fill(model: oneGameResponse?) {
      titleLabel.text = model?.title ?? ""
      descriptionLabel.text = model?.genre ?? ""
      let url = model?.thumbnail! ?? ""
      gameImage.setImage(imageUrl: url)
      gameImage.kf.indicatorType = .activity
      gameImage.contentMode = .scaleAspectFill
      gameImage.layer.cornerRadius = 10
   }
}

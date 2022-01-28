//
//  FirstTableViewCell.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

   @IBOutlet var newImageUIImage: UIImageView!
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var descriptionLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(model: manyGamesResponse?) {
      let url = model?.thumbnail! ?? ""
      newImageUIImage.setImage(imageUrl: url)
      newImageUIImage.kf.indicatorType = .activity
      newImageUIImage.contentMode = .scaleAspectFill
      newImageUIImage.layer.cornerRadius = 10
      
      titleLabel.text = model?.title
      descriptionLabel.text = model?.genre
   }
}

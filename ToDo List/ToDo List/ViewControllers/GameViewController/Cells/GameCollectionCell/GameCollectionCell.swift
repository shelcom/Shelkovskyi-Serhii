//
//  GameCollectionCell.swift
//  ToDoList
//
//  Created by Serhii on 25.01.2022.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {

   @IBOutlet var image: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(model: Screenshots?) {
      let oneImage = model?.image
      let url = oneImage
      image.setImage(imageUrl: url ?? "")
      image.kf.indicatorType = .activity
      image.contentMode = .scaleAspectFill
      image.layer.cornerRadius = 6
   }
}

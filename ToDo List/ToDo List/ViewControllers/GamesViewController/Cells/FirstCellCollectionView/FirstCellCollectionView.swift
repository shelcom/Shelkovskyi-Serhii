//
//  FirstCellCollectionView.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit

class FirstCellCollectionView: UICollectionViewCell {

   @IBOutlet var nameLabel: UILabel!
   @IBOutlet var categoryLabel: UILabel!
   @IBOutlet var imageView: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(model: manyGamesResponse?) {
      let url = model?.thumbnail! ?? ""
      imageView.setImage(imageUrl: url)
      imageView.kf.indicatorType = .activity
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = 10
      
      nameLabel.text = model?.title ?? ""
      categoryLabel.text = model?.genre ?? ""
   }
}

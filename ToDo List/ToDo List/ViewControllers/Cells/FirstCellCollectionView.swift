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
}

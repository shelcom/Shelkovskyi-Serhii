//
//  FirstViewCell.swift
//  ToDoList
//
//  Created by Serhii on 16.01.2022.
//

import UIKit

class FirstViewCell: UICollectionViewCell {
   
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var valueLabel: UILabel!

   override func awakeFromNib() {
      super.awakeFromNib()
        
      contentView.layer.cornerRadius = 12
      contentView.backgroundColor =  UIColor.black.withAlphaComponent(0.25)
   }
   
   func fill(with model: AboutWather?) {
      let value = "\(model?.doubleValue ?? 0)"
      
      titleLabel.text = model?.title
      valueLabel.text = value
   }
}

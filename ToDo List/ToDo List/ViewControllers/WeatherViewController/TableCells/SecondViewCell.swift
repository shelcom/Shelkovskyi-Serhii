//
//  SecondViewCell.swift
//  ToDoList
//
//  Created by Serhii on 16.01.2022.
//

import UIKit

class SecondViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       contentView.layer.cornerRadius = 12
    }
   
   func fill(with model: AboutWather?) {
//      title.text = model?.title
   }

}

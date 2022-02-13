//
//  SeventhViewCell.swift
//  ToDoList
//
//  Created by Serhii on 16.01.2022.
//

import UIKit

class SeventhViewCell: UICollectionViewCell {
   
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var valueLabel: UILabel!
   
   var weatherViewModel = WeatherViewModel()

   override func awakeFromNib() {
      super.awakeFromNib()
      
      contentView.layer.cornerRadius = 12
      contentView.backgroundColor =  UIColor.black.withAlphaComponent(0.25)
   }
   
   func fill(with model: AboutWather?) {
      let value = "\(model?.doubleValue ?? 0)"
      titleLabel.text = model?.title
      valueLabel.text = weatherViewModel.formateValueForVisibility(value: value)
   }
}

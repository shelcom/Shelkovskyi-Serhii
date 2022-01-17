//
//  FirstCollectionViewCell.swift
//  ToDoList
//
//  Created by Serhii on 14.01.2022.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
   
   @IBOutlet var timeLabel: UILabel!
   @IBOutlet var tempLabel: UILabel!
   @IBOutlet var imageView: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(with model: WeatherForFifteenHours) {
      guard let time = model.timestampLocal else { return }
      guard let temp = model.temp else { return }
      guard let icon = model.weather?.icon else { return }
      
      timeLabel.text = "\(time)"
      imageView.image = UIImage(named: icon)
      tempLabel.text = "\(temp)"
   }
}

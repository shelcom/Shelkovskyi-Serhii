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
   
   var weatherController = WeatherController()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      contentView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
   }
   
   func fill(with model: WeatherForFifteenHours) {
      guard let time = model.timestampLocal else { return }
      guard let temp = model.temp else { return }
      guard let icon = model.weather?.icon else { return }
      let tempToString: String = "\(temp)"
      
      timeLabel.text = weatherController.formatDateForHours(date: time)
      imageView.image = UIImage(named: icon)
      tempLabel.text = weatherController.formatMinAndMaxTemp(temp: tempToString)
   }
}

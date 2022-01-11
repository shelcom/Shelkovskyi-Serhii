//
//  WeatherTableViewCell.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
   @IBOutlet var minTempLabel: UILabel!
   @IBOutlet var maxTempLabel: UILabel!
   @IBOutlet var weatherImage: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(with model: Weather) {
      guard let minTemp = model.minTemp else { return }
      guard let maxTemp = model.maxTemp else { return }
      guard let icon = model.weather?.icon else { return }
      
      minTempLabel.text = "\(minTemp)"
      maxTempLabel.text = "\(maxTemp)"
      weatherImage.image = UIImage(named: icon)
   }
}

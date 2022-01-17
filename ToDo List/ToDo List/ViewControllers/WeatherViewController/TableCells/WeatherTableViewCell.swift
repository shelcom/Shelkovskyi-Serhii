//
//  WeatherTableViewCell.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
   @IBOutlet var minTempLabel: UILabel!
   @IBOutlet var weatherImage: UIImageView!
   @IBOutlet var view: UIView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareView()
   }
   
   func prepareView() {
//         contentView.layer.cornerRadius = 12.0
//         view.layer.cornerRadius = 12.0
         view.backgroundColor = UIColor.gray
      }
   
   func fill(with model: Weathers) {
      guard let minTemp = model.minTemp else { return }
//      guard let maxTemp = model.maxTemp else { return }
      guard let icon = model.weather?.icon else { return }
      
      minTempLabel.text = "\(minTemp)"
      weatherImage.image = UIImage(named: icon)
   }
}

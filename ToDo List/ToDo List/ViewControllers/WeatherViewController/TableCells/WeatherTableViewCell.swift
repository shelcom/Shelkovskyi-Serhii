//
//  WeatherTableViewCell.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

   @IBOutlet var dayLabel: UILabel!
   @IBOutlet var weatherImage: UIImageView!
   @IBOutlet var minTempLabel: UILabel!
   @IBOutlet var maxTempLabel: UILabel!
   
   var weatherViewModel = WeatherViewModel()
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(with model: Weathers) {
      guard let date = model.dateTime else { return }
      guard let minTemp = model.minTemp else { return }
      guard let maxTemp = model.maxTemp else { return }
      guard let icon = model.weather?.icon else { return }
      let minTempToString: String = "\(minTemp)"
      let maxTempToString: String = "\(maxTemp)"
      let newDate = weatherViewModel.formatDate(date: date)
      
      weatherImage.image = UIImage(named: icon)
      dayLabel.text = "\(newDate)"
      minTempLabel.text = weatherViewModel.formatMinAndMaxTemp(temp: minTempToString)
      maxTempLabel.text = weatherViewModel.formatMinAndMaxTemp(temp: maxTempToString)
   }
}

//
//  Weather.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import Foundation
import Alamofire

struct WeatherResponse: Decodable {
   var data: [Weather]?
}

struct Weather: Decodable {
   var minTemp: Double?
   var maxTemp: Double?
   var weather: WeatherImage?
   
   enum CodingKeys : String, CodingKey {
      case minTemp = "min_temp"
      case maxTemp = "max_temp"
      case weather
   }
}

struct WeatherImage: Codable {
   var icon: String?
}

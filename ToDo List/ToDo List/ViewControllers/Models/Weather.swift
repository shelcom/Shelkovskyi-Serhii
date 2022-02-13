//
//  Weather.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import Foundation
import Alamofire

struct WeathersResponse: Decodable {
   
   var data: [Weathers]?
}

struct WeatherResponse: Decodable {
   
   var data: [Weather]?
}

struct WeatherResponseForFifteenHours: Decodable {
   
   var data: [WeatherForFifteenHours]?
}

struct Weather: Decodable {
   
   var cityName: String?
   var temp: Double?
   var weather: WeatherImageAndDescription?
   
   enum CodingKeys : String, CodingKey {
      case cityName = "city_name"
      case temp
      case weather
   }
}

struct AboutWather {
   
   var title: String?
   var intValue: Int?
   var type: NumberType
   var doubleValue: Double?
}

public enum NumberType {
   case first
   case second
   case third
   case fourth
   case fifth
   case sixth
   case seventh
   case eighth
}

struct WeatherForFifteenHours: Decodable {
   
   var timestampLocal: String?
   var temp: Double?
   var weather: WeatherImageAndDescription?
   
   enum CodingKeys : String, CodingKey {
      case timestampLocal = "timestamp_local"
      case temp
      case weather
   }
}

struct Weathers: Decodable {
   
   var minTemp: Double?
   var maxTemp: Double?
   var weather: WeatherImageAndDescription?
   var cityName: String?
   var uv: Double?
   var sunriseTs: Double?
   var windSpd: Double?
   var dateTime: String?
   var precip: Double?
   var appMaxTemp: Double?
   var rh: Int?
   var vis: Double?
   var pres: Double?
   
   enum CodingKeys : String, CodingKey {
      case minTemp = "min_temp"
      case maxTemp = "max_temp"
      case weather
      case dateTime = "datetime"
      case cityName = "city_name"
      case uv
      case sunriseTs = "sunrise_ts"
      case windSpd = "wind_spd"
      case precip
      case appMaxTemp = "app_max_temp"
      case rh
      case vis
      case pres
   }
}

struct WeatherImageAndDescription: Codable {
   
   var icon: String?
   var description: String?
}

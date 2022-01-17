//
//  WeatherManager.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import Foundation
import Alamofire

class RequestManager {

   private var weather: [Weathers]?
   private var weathers: [Weather]?
   private var weatherForFifteenHours: [WeatherForFifteenHours]?
   
   func requestOfManyDay(headers: HTTPHeaders, url: String, completion: @escaping ([Weathers]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeathersResponse.self) { [self] response in
         weather = response.value?.data ?? nil
         completion(weather)
      }
   }
   
   func requestOfOneDay(headers: HTTPHeaders, url: String, completion: @escaping ([Weather]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeatherResponse.self) { [self] response in
         weathers = response.value?.data ?? nil
         completion(weathers)
      }
   }
   
   func requestOfFifteenHours(headers: HTTPHeaders, url: String, completion: @escaping ([WeatherForFifteenHours]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeatherResponseForFifteenHours.self) { [self] response in
         weatherForFifteenHours = response.value?.data ?? nil
         completion(weatherForFifteenHours)
      }
   }
}

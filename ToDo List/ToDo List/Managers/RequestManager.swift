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
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeathersResponse.self) { [weak self] response in
         guard let self = self else { return }
         self.weather = response.value?.data ?? nil
         completion(self.weather)
      }
   }
   
   func requestOfOneDay(headers: HTTPHeaders, url: String, completion: @escaping ([Weather]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeatherResponse.self) { [weak self] response in
         guard let self = self else { return }
         self.weathers = response.value?.data ?? nil
         completion(self.weathers)
      }
   }
   
   func requestOfFifteenHours(headers: HTTPHeaders, url: String, completion: @escaping ([WeatherForFifteenHours]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeatherResponseForFifteenHours.self) { [weak self] response in
         guard let self = self else { return }
         self.weatherForFifteenHours = response.value?.data ?? nil
         completion(self.weatherForFifteenHours)
      }
   }
}

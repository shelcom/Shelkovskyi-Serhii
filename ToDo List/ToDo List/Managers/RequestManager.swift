//
//  WeatherManager.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import Foundation
import Alamofire

protocol OpenWeatherMapDelegate {
   func updateWeatherInfo()
}

class RequestManager {
   
   var delegate: OpenWeatherMapDelegate!
   var weather: [Weather]?
   
   func request(headers: HTTPHeaders, url: String) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: WeatherResponse.self) { [self] response in
         weather = response.value?.data ?? nil
         
         self.delegate.updateWeatherInfo()
      }
   }
   
}

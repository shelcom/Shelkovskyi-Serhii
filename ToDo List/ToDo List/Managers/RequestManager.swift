//
//  WeatherManager.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import Foundation
import Alamofire

class RequestManager {

   private var game: oneGameResponse?
   private var gamesTop: [topGameResponse]?
   private var gamesBottom: [topGameResponse]?
   
   func requestOfOneGame(headers: HTTPHeaders, url: String) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: oneGameResponse.self) { [self] response in
         game = response.value ?? nil
//         completion(weather)
      }
   }
   
   func requestForTopGame(headers: HTTPHeaders, url: String, completion: @escaping ([topGameResponse]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: [topGameResponse].self) { [self] response in
         gamesTop = response.value ?? nil
         completion(gamesTop)
      }
   }
   
   func requestForBottomGame(headers: HTTPHeaders, url: String) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: [topGameResponse].self) { [self] response in
         gamesBottom = response.value ?? nil
//         completion(weather)
      }
   }
}

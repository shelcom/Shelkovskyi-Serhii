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
   private var gamesTop: [manyGamesResponse]?
   private var gamesBottom: [manyGamesResponse]?
   
   func requestOfOneGame(headers: HTTPHeaders, url: String, completion: @escaping (oneGameResponse?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: oneGameResponse.self) { [self] response in
         game = response.value ?? nil
         completion(game)
      }
   }
   
   func requestGames(headers: HTTPHeaders, url: String, completion: @escaping ([manyGamesResponse]?) -> Void) {
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseDecodable(of: [manyGamesResponse].self) { [self] response in
         gamesTop = response.value ?? nil
         completion(gamesTop)
      }
   }
}

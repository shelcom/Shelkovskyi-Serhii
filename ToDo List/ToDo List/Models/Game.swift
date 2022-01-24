//
//  Game.swift
//  ToDoList
//
//  Created by Serhii on 22.01.2022.
//

import Foundation
import Alamofire

struct oneGameResponse: Decodable {
   
   var id: Int?
   var title: String?
   var description: String?
   var screenshots : [Screenshots]?
   
   enum CodingKeys : String, CodingKey {
      case id
      case title
      case description
      case screenshots
   }
}

struct Screenshots: Codable {
   
   var image: String?
}

struct topGameResponse: Decodable {
   
   var id: Int?
   var title: String?
   var thumbnail: String?
   var genre: String?
   var screenshots : [Screenshots]?
   
   enum CodingKeys : String, CodingKey {
      case id
      case title
      case thumbnail
      case genre
      case screenshots
   }
}

//
//  Game.swift
//  ToDoList
//
//  Created by Serhii on 22.01.2022.
//

import Foundation
import Alamofire

struct TableRowModel {
   var collectionCells : [CollectionCellModel]?
}

struct CollectionCellModel {
   var applications : [manyGamesResponse]?
}

struct manyGamesResponse: Decodable {
   var id: Int?
   var title: String?
   var thumbnail: String?
   var genre: String?
   var description: String?
   var screenshots : [Screenshots]?
   
   enum CodingKeys : String, CodingKey {
      case id
      case title
      case thumbnail
      case genre
      case description
      case screenshots
   }
}

struct oneGameResponse: Decodable {
   var id: Int?
   var title: String?
   var genre: String?
   var thumbnail: String?
   var description: String?
   var screenshots: [Screenshots]?
   
   enum CodingKeys : String, CodingKey {
      case id
      case title
      case genre
      case thumbnail
      case description
      case screenshots
   }
}

struct Screenshots: Decodable {
   var image: String?
}

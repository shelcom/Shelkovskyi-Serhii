//
//  GamesController.swift
//  ToDoList
//
//  Created by Serhii on 27.01.2022.
//

import Foundation

class GamesController {
   
   var noOfRows: [TableRowModel]?
   var arrayGamesFirst: [manyGamesResponse] = []
   var arrayGamesSecond: [manyGamesResponse] = []
   
   func prepareData(gameArr: [manyGamesResponse]?) -> TableRowModel {
      fillGameArray(gameArr: gameArr)
      
      let firstRowFirstCell = CollectionCellModel(applications: arrayGamesFirst)
      let firstRowSecondCell = CollectionCellModel(applications: arrayGamesFirst)
      
      return TableRowModel(collectionCells: [firstRowFirstCell, firstRowSecondCell])
   }
   
   func fillGameArray(gameArr: [manyGamesResponse]?) {
      for i in 0...2 {
         arrayGamesFirst.append((gameArr?[i])!)
      }
      
      for i in 3...5 {
         arrayGamesSecond.append((gameArr?[i])!)
      }
   }
}

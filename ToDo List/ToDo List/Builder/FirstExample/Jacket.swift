//
//  Parka.swift
//  ToDoList
//
//  Created by Serhii on 30.01.2022.
//

import Foundation

class Jacket {
   
   var parka: Parka
   
   init(parka: Parka) {
      self.parka = parka
   }

   func addHood() -> Jacket {
      parka.hood = true
      return self
   }
   
   func addLock() -> Jacket {
      parka.lock = true
      return self
   }
   
   func addPocket(countPocket: Int) -> Jacket {
      parka.pocket = parka.pocket ?? 0 + countPocket
      return self
   }
   
   func addButton(countButton: Int) -> Jacket {
      parka.button = parka.button ?? 0 + countButton
      return self
   }
   
   func finish() -> Parka {
      return self.parka
   }
}

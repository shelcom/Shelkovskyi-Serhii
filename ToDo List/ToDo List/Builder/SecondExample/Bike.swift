//
//  Bike.swift
//  ToDoList
//
//  Created by Serhii on 31.01.2022.
//

import Foundation

class Bike {
   
   var polygon: Polygon
   
   init(polygon: Polygon) {
      self.polygon = polygon
   }

   func addTrunk() -> Bike {
      polygon.trunk = false
      return self
   }
   
   func addWheels() -> Bike {
      polygon.wheels = 2
      return self
   }
   
   func addWheelDiameter() -> Bike {
      polygon.wheelDiameter = 27.5
      return self
   }
   
   func finish() -> Polygon {
      return self.polygon
   }
}

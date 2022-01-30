//
//  BuilderSecondViewController.swift
//  ToDoList
//
//  Created by Serhii on 31.01.2022.
//

import UIKit

class BuilderSecondViewController: UIViewController {

   @IBOutlet var titleLabel: UILabel!
   
   var polygon = Bike(polygon: Polygon())
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      createPolygon()
   }
   
   func createPolygon() {
      let createPolygon = polygon.addTrunk().addWheels().addWheelDiameter().finish()
      titleLabel.text = "Polygon have: trunk - \(createPolygon.trunk ?? false), wheels - \(createPolygon.wheels ?? 0), wheel diametr - \(createPolygon.wheelDiameter ?? 0)"
   }
}

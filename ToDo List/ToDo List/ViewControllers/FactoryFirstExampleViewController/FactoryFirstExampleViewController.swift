//
//  FactoryFirstExampleViewController.swift
//  ToDoList
//
//  Created by Serhii on 30.01.2022.
//

import UIKit

class FactoryFirstExampleViewController: UIViewController {

   @IBOutlet var titleLabel: UILabel!
   
   var startDoExercise = StartDoExercise()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   @IBAction func pressJump(_ sender: Any) {
      titleLabel.text = startDoExercise.doExercise(exercise: Jumping())
   }
   
   @IBAction func pressRunning(_ sender: Any) {
      titleLabel.text = startDoExercise.doExercise(exercise: Running())
   }
}

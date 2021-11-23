//
//  UserDataViewController.swift
//  ToDo List
//
//  Created by Serhii on 19.11.2021.
//

import UIKit

class UserDataViewController: UIViewController {
   
   @IBOutlet var nameTextField: UITextField!
   @IBOutlet var currentNumberTextField: UITextField!
   @IBOutlet var currentCalloriesTextField: UITextField!
   @IBOutlet var currentWeightLabel: UILabel!
   @IBOutlet var currentLengthLabel: UILabel!
   @IBOutlet var currentPeriodLabel: UILabel!
   @IBOutlet var weightSlider: UISlider!
   @IBOutlet var lengthSlider: UISlider!
   @IBOutlet var periodSlider: UISlider!
   @IBOutlet var currentPlanSegment: UISegmentedControl!
   
   var userController = UserController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPhoto1")!)
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   @IBAction func changeValueSliderAction(_ sender: Any) {
      guard let sender = sender as? UISlider else {return}
      if sender == weightSlider {
          currentWeightLabel.text = "\(Int(sender.value))"
      } else if sender == lengthSlider {
          currentLengthLabel.text = "\(Int(sender.value))"
      } else if sender == periodSlider {
          currentPeriodLabel.text = "\(Int(sender.value))"
      }
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard segue.identifier == "HomeScreenViewController" else { return }
      guard let destination = segue.destination as? HomeScreenViewController else { return }
      
      let user = userController.addNewUser(name: nameTextField.text, contactNumber: currentNumberTextField.text, currentWeight: Int(weightSlider.value), currentLength: Int(lengthSlider.value), calories: Int(currentCalloriesTextField.text!), choosePlan: currentPlanSegment.selectedSegmentIndex, period: Int(periodSlider.value))
      UserManager.shared.choosePlans(user: user)
      guard user != nil else { return }
      destination.plan = user!.currentPlan
   }
}

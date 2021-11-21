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
   @IBOutlet var getWeightSwitch: UISwitch!
   @IBOutlet var loseWeightSwitch: UISwitch!
   @IBOutlet var maintainingWeightSwitch: UISwitch!
   
   var userCv = UserController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
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
   
   @IBAction func changeFirstSwitch(_ sender: Any) {
      if (sender as AnyObject).isOn {
         loseWeightSwitch.isOn = false
         maintainingWeightSwitch.isOn = false
      }
   }
   
   @IBAction func changeSecondSwitch(_ sender: Any) {
      if (sender as AnyObject).isOn {
         getWeightSwitch.isOn = false
         maintainingWeightSwitch.isOn = false
      }
   }
   
   @IBAction func changeThirdSwitch(_ sender: Any) {
      if (sender as AnyObject).isOn {
         loseWeightSwitch.isOn = false
         getWeightSwitch.isOn = false
      }
   }
   
   func choosePlan() -> String {
      if getWeightSwitch.isOn {
         return "getWeightPlan"
      } else if loseWeightSwitch.isOn {
         return "loseWeightPlan"
      } else {
         return "maintainingWeightPlan"
      }
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard segue.identifier == "HomeScreenViewController" else { return }
      guard let destination = segue.destination as? HomeScreenViewController else { return }
      
      let user = userCv.addNewUser(name: nameTextField.text, contactNumber: currentNumberTextField.text, currentWeight: Int(weightSlider.value), currentLength: Int(lengthSlider.value), calories: Int(currentCalloriesTextField.text!), choosePlan: choosePlan(), period: Int(periodSlider.value))
      UserManager.shared.choosePlans(user: user)
      destination.plan = user!.currentPlan
   }
}

//
//  NotificationViewController.swift
//  ToDo List
//
//  Created by Serhii on 20.12.2021.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
   
   @IBOutlet var addNotificationButton: UIButton!
   @IBOutlet var timeAndDatePicker: UIDatePicker!
   @IBOutlet var backButton: UIButton!
   
   var note: Note? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   func goBack() {
      let storyBoard: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
      let vC = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
      self.show(vC, sender: nil)
   }

   @IBAction func sendNotification(_ sender: UIButton) {
      let content = UNMutableNotificationContent()
      content.body = note?.text ?? ""
      content.sound = UNNotificationSound.default
      
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: timeAndDatePicker.date)
      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
      let request = UNNotificationRequest(identifier: String(note?.id ?? 1), content: content, trigger: trigger)
      let center = UNUserNotificationCenter.current()
      center.add(request, withCompletionHandler: nil)
      
      goBack()
   }
   
   @IBAction func presssBack(_ sender: Any) {
      goBack()
   }
}

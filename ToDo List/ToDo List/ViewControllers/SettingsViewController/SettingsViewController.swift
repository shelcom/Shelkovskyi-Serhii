//
//  SettingsViewController.swift
//  ToDo List
//
//  Created by Serhii on 15.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
   
   @IBOutlet var settingsTable: UITableView!
   
   let settingsTitle = ["Exit"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      prepareTableView()
   }
   
   func prepareTableView() {
      settingsTable.delegate = self
      settingsTable.dataSource = self
      settingsTable.register(UINib.init(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
   }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      settingsTitle.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsTableViewCell
      cell.fill(title: settingsTitle[indexPath.row])
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      UserDefaults.standard.setValue(nil, forKey: "currentUserId")
      performSegue(withIdentifier: "goToMainStoryboard", sender: self)
   }
}

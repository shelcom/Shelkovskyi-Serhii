//
//  SettingsTableViewCell.swift
//  ToDo List
//
//  Created by Serhii on 15.12.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
   
   @IBOutlet var titleLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func fill(title: String) {
      titleLabel.text = title
   }
}

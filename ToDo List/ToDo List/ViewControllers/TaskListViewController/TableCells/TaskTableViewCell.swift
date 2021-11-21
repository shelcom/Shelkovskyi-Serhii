//
//  TaskTableViewCell.swift
//  ToDo List
//
//  Created by Serhii on 09.11.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
  
   @IBOutlet var createDateLable: UILabel!
   @IBOutlet var startDateLable: UILabel!
   @IBOutlet var titleLable: UILabel!

   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   // fill taskTableCell
   func fill(with model: Task) {
      titleLable.text = model.title
      createDateLable.text = "01.01.2000"
      startDateLable.text = "02.01.2000"
   }
}

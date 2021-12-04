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
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMMM d, HH:mm"
      let taskDateString = dateFormatter.string(from: model.taskDate)
      let createdDateString = dateFormatter.string(from: model.createdDate)
      
      startDateLable.text = "start day" + " " + taskDateString
      createDateLable.text = "create day" + " " + createdDateString
   }
}

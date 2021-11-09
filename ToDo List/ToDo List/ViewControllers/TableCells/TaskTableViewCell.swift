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
}

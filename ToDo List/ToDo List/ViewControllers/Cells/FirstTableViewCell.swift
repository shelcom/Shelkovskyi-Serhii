//
//  FirstTableViewCell.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

   @IBOutlet var newImageUIImage: UIImageView!
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var descriptionLabel: UILabel!
   
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
}

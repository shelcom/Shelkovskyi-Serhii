//
//  AllNotesTableViewCell.swift
//  ToDo List
//
//  Created by Serhii on 10.12.2021.
//

import UIKit

class AllNotesTableViewCell: UITableViewCell {
   
   @IBOutlet var titleLable: UILabel!
   @IBOutlet var dateLable: UILabel!
   @IBOutlet var imageUIImageView: UIImageView!
   @IBOutlet var textTitle: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      contentView.layer.cornerRadius = 12.0;
      contentView.backgroundColor = UIColor.white
   }
   
   func fill(with model: Note) {
      titleLable.text = model.title
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMMM d, HH:mm"
      let dateString = dateFormatter.string(from: model.date)
      dateLable.text = dateString
      
//      startDateLable.text = "start day" + " " + taskDateString
//      createDateLable.text = "create day" + " " + createdDateString
      textTitle.text = model.text
      guard let photo = model.photo else { return }
      let image = UIImage(data: photo)
      imageUIImageView.image = image
      
   }

   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   override var frame: CGRect {
      get { return super.frame }
      set (newFrame) {
         var frame = newFrame
         frame.size.width = UIScreen.main.bounds.width * 0.9
         super.frame = frame
      }
   }
}

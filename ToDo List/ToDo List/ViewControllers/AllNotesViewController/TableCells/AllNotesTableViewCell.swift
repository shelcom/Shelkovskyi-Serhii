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
   @IBOutlet var textTitle: UILabel!
   @IBOutlet var favoritesButton: UIButton!
   @IBOutlet var view: UIView!
   @IBOutlet var probaPhoto: UIImageView!
   
   let noteController = NoteController()
   var buttonToggledHandler: ((AllNotesTableViewCell) -> ())?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareView()
   }
   
   func prepareView() {
      contentView.layer.cornerRadius = 12.0
      view.layer.cornerRadius = 12.0
      contentView.backgroundColor = UIColor.white
   }
   
   @IBAction func addNoteToFavorites(_ sender: UIButton) {
      let userId = UserDefaults.standard.integer(forKey: "currentUserId")
      
      if favoritesButton.tag == 0 {
         noteController.addFavoritesNote(title: titleLable.text ?? "", userId: userId)
         let image = UIImage(named: "24pt-clicked-saved") as UIImage?
         favoritesButton.setImage(image, for: .normal)
         favoritesButton.tag = 1
      } else {
         noteController.deleteFavoritesNote(title: titleLable.text ?? "", userId: userId)
         let image = UIImage(named: "24pt-saved") as UIImage?
         favoritesButton.setImage(image, for: .normal)
         favoritesButton.tag = 0
      }
      
      if let buttonToggledHandler = buttonToggledHandler {
         buttonToggledHandler(self)
      }
   }
   
   func fill(with model: Note) {
      titleLable.text = model.title
      
      if model.favorites {
         let image = UIImage(named: "24pt-clicked-saved") as UIImage?
         favoritesButton.setImage(image, for: .normal)
         favoritesButton.tag = 1
      } else {
         let image = UIImage(named: "24pt-saved") as UIImage?
         favoritesButton.setImage(image, for: .normal)
         favoritesButton.tag = 0
      }
      
      formatDate(date: model.date, text: model.text)
      setPhoto(photo: model.photo)
   }
   
   func formatDate(date: Date, text: String) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d MMM, yyyy, HH:mm"
      let dateString = dateFormatter.string(from: date)
      dateLable.text = dateString
      textTitle.text = text
   }
   
   func setPhoto(photo: Data?) {
      if let photo = photo {
         let image = UIImage(data: photo)
         probaPhoto.image = image
      } else {
         probaPhoto.constraints.first(where: { $0.identifier == "heightConstrain" })?.constant = 0
         probaPhoto.constraints.first(where: { $0.identifier == "topConstraint" })?.constant = 0
         probaPhoto.constraints.first(where: { $0.identifier == "widthConstraint" })?.constant = 0
      }
   }
}

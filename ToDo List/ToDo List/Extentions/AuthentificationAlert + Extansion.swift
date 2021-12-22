//
//  AuthentificationAlert + Extansion.swift
//  ToDo List
//
//  Created by Serhii on 06.12.2021.
//

import Foundation
import UIKit

extension UIViewController {
   
   func alert(title: String, message: String) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let cancleAction = UIAlertAction(title: "Ok", style: .default)
      
      alert.addAction(cancleAction)
      present(alert, animated: true, completion: nil)
   }
   
   func alertForEditNote(note: Note) {
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let noteController = NoteController()

      // Create your actions - take a look at different style attributes
      let reportAction = UIAlertAction(title: "Save", style: .default) { (action) in
         noteController.editNote(note: note)
         self.navigationController?.popViewController(animated: true)
      }

      let blockAction = UIAlertAction(title: "Delete Note", style: .destructive) { (action) in
         let center = UNUserNotificationCenter.current()
         center.removePendingNotificationRequests(withIdentifiers: [String(note.id)])
         noteController.deleteNote(note: note)
         self.navigationController?.popViewController(animated: true)
      }

      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }

      // Add the actions to your actionSheet
      alert.addAction(reportAction)
      alert.addAction(blockAction)
      alert.addAction(cancelAction)
      // Present the controller
      self.present(alert, animated: true, completion: nil)
   }
}

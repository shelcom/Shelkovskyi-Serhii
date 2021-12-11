//
//  NotesViewController.swift
//  ToDo List
//
//  Created by Serhii on 08.12.2021.
//

import UIKit

class NotesViewController: UIViewController {

   @IBOutlet var photoUIImageView: UIImageView!
   
   let noteController = NoteController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   //hide navbar
   override func viewDidAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.isHidden = true
      
      loadImage()
   }
   
   func loadImage() {
//      let notes = noteController.findNotes(userId: UserDefaults.standard.integer(forKey: "currentUserId"))
//      print(notes)
//      let image = UIImage(data: (notes.first?.photo!)!)
//      photoUIImageView.image = image
   }
}

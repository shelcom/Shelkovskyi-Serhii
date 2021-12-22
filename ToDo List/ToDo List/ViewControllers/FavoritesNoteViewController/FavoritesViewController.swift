//
//  FavoritesViewController.swift
//  ToDo List
//
//  Created by Serhii on 17.12.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
   
   @IBOutlet var favoritesTable: UITableView!
   
   let noteController = NoteController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      prepareTableView()
   }
   
   func prepareTableView() {
      favoritesTable.delegate = self
      favoritesTable.dataSource = self
      favoritesTable.register(UINib.init(nibName: "AllNotesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllNotesCell")
      
      favoritesTable.separatorStyle = .none
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
      favoritesTable.reloadData()
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
   }
}

extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      return noteController.favoritesNoteCount(userId: currentUserId)
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "AllNotesCell") as! AllNotesTableViewCell
      cell.fill(with: noteController.favoritesNoteByIndex(by: indexPath.row, userId: currentUserId))
   
      cell.buttonToggledHandler = { [weak self] buttonToggledHandler in
         guard let self = self else { return }
         self.favoritesTable.reloadData()
      }
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "EditNoteViewController", sender: indexPath.row)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "EditNoteViewController" {
         guard let vc = segue.destination as? EditNoteViewController else { return }
         let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
         let note = findNote(sender: sender as! Int, currentUserId: currentUserId)
         vc.note = note
      }
   }
   
   func findNote(sender: Int, currentUserId: Int) -> Note {
      return noteController.favoritesNoteByIndex(by: sender, userId: currentUserId)
   }
}

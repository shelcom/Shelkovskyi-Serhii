//
//  SearcheNoteViewController.swift
//  ToDo List
//
//  Created by Serhii on 17.12.2021.
//

import UIKit

class SearcheNoteViewController: UIViewController {
   
   @IBOutlet var searchBar: UISearchBar!
   @IBOutlet var searcheTable: UITableView!
   
   let noteController = NoteController()
   var searchBarText: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
   
      prepareSearchBar()
      prepareTableView()
   }
   
   func prepareSearchBar() {
      searchBar.delegate = self
   }
   
   func prepareTableView() {
      searcheTable.delegate = self
      searcheTable.dataSource = self
      searcheTable.register(UINib.init(nibName: "AllNotesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllNotesCell")
      
      searcheTable.separatorStyle = .none
      searcheTable.keyboardDismissMode = .onDrag
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
      
      searchBarText = nil
      searcheTable.reloadData()
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
      
      searchBar.text = nil
   }
}

extension SearcheNoteViewController: UISearchBarDelegate {

   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      let text = self.searchBar.text ?? ""
      searchBarText = text

      noteController.searchUserNotes(text: text, userId: UserDefaults.standard.integer(forKey: "currentUserId"))
      searcheTable.reloadData()
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(true)
   }
   
}

extension SearcheNoteViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      return noteController.searchNotesCount(userId: currentUserId, searchText: searchBarText ?? "")
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AllNotesCell") as! AllNotesTableViewCell
      cell.fill(with: noteController.searchNote(by: indexPath.row))

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
      return noteController.searchNote(by: sender)
   }
}

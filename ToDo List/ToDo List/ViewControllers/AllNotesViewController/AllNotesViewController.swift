//
//  SecondViewController.swift
//  ToDo List
//
//  Created by Serhii on 07.12.2021.
//

import UIKit

class AllNotesViewController: UIViewController {
   
   @IBOutlet var notesTable: UITableView!
   @IBOutlet var searchBar: UISearchBar!
   @IBOutlet var allTagsButton: UIButton!
   @IBOutlet var firstTagButton: UIButton!
   @IBOutlet var secondTagButton: UIButton!
   
   let noteController = NoteController()
   var activeTag = "allTag"
   
   override func viewDidLoad() {
      super.viewDidLoad()
       
      prepareTableView()
      searchBar.delegate = self
      
      allTagsButton.layer.cornerRadius = 12.0
      firstTagButton.layer.cornerRadius = 12.0
      secondTagButton.layer.cornerRadius = 12.0
      
      if allTagsButton.isEnabled {
         allTagsButton.backgroundColor = UIColor(named: "buttonActiveColor")
         allTagsButton.setTitleColor(.white, for: .normal)
      }
   }
   
   func prepareTableView() {
      notesTable.delegate = self
      notesTable.dataSource = self
      notesTable.register(UINib.init(nibName: "AllNotesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllNotesCell")
   }
   
   @IBAction func tagNotes(_ sender: UIButton) {
      if sender == allTagsButton {
         
      } else if sender == firstTagButton {
         activeTag = "firstTag"
         sender.backgroundColor = UIColor(named: "buttonActiveColor")
         sender.setTitleColor(.white, for: .normal)
         allTagsButton.backgroundColor = UIColor(named: "tableColor")
         allTagsButton.setTitleColor(.black, for: .normal)
         secondTagButton.backgroundColor = UIColor(named: "tableColor")
         secondTagButton.setTitleColor(.black, for: .normal)
      } else {
         activeTag = "secondTag"
         sender.backgroundColor = UIColor(named: "buttonActiveColor")
         sender.setTitleColor(.white, for: .normal)
         allTagsButton.backgroundColor = UIColor(named: "tableColor")
         allTagsButton.setTitleColor(.black, for: .normal)
         firstTagButton.backgroundColor = UIColor(named: "tableColor")
         firstTagButton.setTitleColor(.black, for: .normal)
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      notesTable.reloadData()
   }
}

extension AllNotesViewController: UITableViewDelegate,UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      
      if searchBar.text!.isEmpty {
         return noteController.notesCount(userId: currentUserId)
      } else {
//         return noteController.filterNotesForTag(tag: activeTag, userId: currentUserId)
         return 5
      }
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 50
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AllNotesCell") as! AllNotesTableViewCell
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      
      if searchBar.text!.isEmpty {
         cell.fill(with: noteController.note(by: indexPath.row, userId: currentUserId))
      } else {
         cell.fill(with: noteController.searchNote(by: indexPath.row))
      }
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 300
   }
   
   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 50
   }
}

extension AllNotesViewController: UISearchBarDelegate {
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      guard let text = self.searchBar.text else { return }
      
      noteController.searchUserNotes(text: text, userId: UserDefaults.standard.integer(forKey: "currentUserId"))
      notesTable.reloadData()
   }
}

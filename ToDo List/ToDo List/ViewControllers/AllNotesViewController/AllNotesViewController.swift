//
//  SecondViewController.swift
//  ToDo List
//
//  Created by Serhii on 07.12.2021.
//

import UIKit

class AllNotesViewController: UIViewController {
   
   @IBOutlet var notesTable: UITableView!
   @IBOutlet var allTagsButton: UIButton!
   @IBOutlet var firstTagButton: UIButton!
   @IBOutlet var secondTagButton: UIButton!
   
   let noteController = NoteController()
   var activeTag = tag.allTag.rawValue
   
   override func viewDidLoad() {
      super.viewDidLoad()
       
      prepareTableView()
      prepareButton()
   }
   
   func prepareButton() {
      allTagsButton.layer.cornerRadius = 12.0
      firstTagButton.layer.cornerRadius = 12.0
      secondTagButton.layer.cornerRadius = 12.0
   }
   
   func prepareTableView() {
      notesTable.delegate = self
      notesTable.dataSource = self
      notesTable.register(UINib.init(nibName: "AllNotesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllNotesCell")
   }
   
   @IBAction func tagNotes(_ sender: UIButton) {
      if sender == allTagsButton {
         activeTag = tag.allTag.rawValue
         sender.backgroundColor = UIColor(named: "buttonActiveColor")
         firstTagButton.backgroundColor = UIColor(named: "tableColor")
         secondTagButton.backgroundColor = UIColor(named: "tableColor")
         notesTable.reloadData()
      } else if sender == firstTagButton {
         activeTag = tag.firstTag.rawValue
         sender.backgroundColor = UIColor(named: "buttonActiveColor")
         allTagsButton.backgroundColor = UIColor(named: "tableColor")
         secondTagButton.backgroundColor = UIColor(named: "tableColor")
         notesTable.reloadData()
      } else {
         activeTag = tag.secondTag.rawValue
         sender.backgroundColor = UIColor(named: "buttonActiveColor")
         allTagsButton.backgroundColor = UIColor(named: "tableColor")
         firstTagButton.backgroundColor = UIColor(named: "tableColor")
         notesTable.reloadData()
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      allTagsButton.backgroundColor = UIColor(named: "buttonActiveColor")
      firstTagButton.backgroundColor = UIColor(named: "tableColor")
      secondTagButton.backgroundColor = UIColor(named: "tableColor")
      activeTag = tag.allTag.rawValue
      
      navigationController?.setNavigationBarHidden(true, animated: animated)
      
      notesTable.reloadData()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      navigationController?.setNavigationBarHidden(false, animated: animated)
      self.tabBarController?.tabBar.isHidden = false
      self.tabBarController?.tabBar.layer.zPosition = -0
   }
}

extension AllNotesViewController: UITableViewDelegate,UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      return noteController.notesCount(userId: currentUserId, tag: activeTag)
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AllNotesCell") as! AllNotesTableViewCell
      let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
      cell.fill(with: noteController.note(by: indexPath.row, userId: currentUserId, tag: activeTag))
      notesTable.separatorStyle = .none
   
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
      noteController.note(by: sender, userId: currentUserId, tag: activeTag)
   }
}

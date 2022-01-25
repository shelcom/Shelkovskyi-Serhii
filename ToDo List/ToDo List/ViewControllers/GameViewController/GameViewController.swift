//
//  GameViewController.swift
//  ToDoList
//
//  Created by Serhii on 22.01.2022.
//

import UIKit

class GameViewController: UIViewController {
   
   @IBOutlet var gamesTable: UITableView!

   override func viewDidLoad() {
      super.viewDidLoad()
      
      prepareForTable()
   }
   
   func prepareForTable() {
      self.gamesTable.delegate = self
      self.gamesTable.dataSource = self
      
      gamesTable.register(UINib.init(nibName: "FirstGameCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
      gamesTable.register(UINib.init(nibName: "SecondGameCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
   }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 2
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      if indexPath.row == 0 {
         let cell = gamesTable.dequeueReusableCell(withIdentifier: "FirstCell") as! FirstGemaCell
         return cell
      } else {
         let cell = gamesTable.dequeueReusableCell(withIdentifier: "SecondCell") as! SecondGameCell
         return cell
      }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.row == 0{
          return 220
      }
      return 300
   }
}


//
//  GameViewController.swift
//  ToDoList
//
//  Created by Serhii on 22.01.2022.
//

import UIKit
import Alamofire

class GameViewController: UIViewController {
   
   @IBOutlet var gamesTable: UITableView!
   
   var gameId: String?
   var oneGame: oneGameResponse?
   var requestManager = RequestManager()
   let headers: HTTPHeaders = [
      "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
      "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
   ]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      addButton()
      prepareForTable()
      oneGameRequest(id: gameId)
   }
   
   func addButton() {
      let button = UIButton(type: .system)
      button.setImage(UIImage(named: "buttonBack"), for: .normal)
      button.setTitle("Games", for: .normal)
      button.sizeToFit()
      button.addTarget(self, action: #selector(self.back), for: .touchUpInside)
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
   }
   
   func prepareForTable() {
      self.gamesTable.delegate = self
      self.gamesTable.dataSource = self
      
      gamesTable.register(UINib.init(nibName: "FirstGameCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
      gamesTable.register(UINib.init(nibName: "SecondGameCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
   }
   
   @objc func back(sender: UIBarButtonItem) {
      navigationController?.popViewController(animated: true)
   }
   
   func oneGameRequest(id: String?) {
      let url = "https://free-to-play-games-database.p.rapidapi.com/api/game?id=\(id ?? "")"
      
      requestManager.requestOfOneGame(headers: headers, url: url){ [self] response in
         oneGame = response
         gamesTable.reloadData()
      }
   }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 2
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.row == 0 {
         let cell = gamesTable.dequeueReusableCell(withIdentifier: "FirstCell") as! FirstGameCell
         cell.fill(model: oneGame)
         return cell
      } else {
         let cell = gamesTable.dequeueReusableCell(withIdentifier: "SecondCell") as! SecondGameCell
         return cell
      }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.row == 0 {
         return 130
      }
      return 200
   }
}

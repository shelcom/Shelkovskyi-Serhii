//
//  AppsViewController.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit
import Alamofire

class AppsViewController: UIViewController {

   @IBOutlet var appsTable: UITableView!
   @IBOutlet var imageBarButton: UIBarButtonItem!
   
   var requestManager = RequestManager()
   
   var titlesArray = ["Popular","Featured"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.tabBarItem.image = UIImage(named: "apps")
      self.navigationItem.largeTitleDisplayMode = .always
      
//      oneGameRequest()
//      gameForBottomRequest()
      prepareForTable()
   }
   
   func oneGameRequest() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      
      let url = "https://free-to-play-games-database.p.rapidapi.com/api/game?id=452"
      
      requestManager.requestOfOneGame(headers: headers, url: url)
   }
   
   func gameForBottomRequest() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      
      let url = "https://free-to-play-games-database.p.rapidapi.com/api/game?id=452"
      
      requestManager.requestOfOneGame(headers: headers, url: url)
   }
   
   func prepareForTable() {
      self.appsTable.delegate = self
      self.appsTable.dataSource = self
      
      appsTable.register(UINib.init(nibName: "AppsFirstCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
      appsTable.register(UINib.init(nibName: "AppsSecondCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
   }
}

extension AppsViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      titlesArray.count
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      if indexPath.row == 0{
         let cell = appsTable.dequeueReusableCell(withIdentifier: "FirstCell") as! AppsFirstCell
         return cell
      } else{
         let cell = appsTable.dequeueReusableCell(withIdentifier: "SecondCell") as! AppsSecondCell
//         cell.titleLabel.text = titlesArray[indexPath.row-1]
//          cell.rowData = self.appdel.noOfRows?[indexPath.row-1]
         return cell
      }
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if indexPath.row == 0{
//         let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController")
//               vc.modalPresentationStyle = .overFullScreen
//         //      s
//         present(vc, animated: true, completion: nil)
      }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.row == 0{
           return 275
       }
       return 250
   }
}

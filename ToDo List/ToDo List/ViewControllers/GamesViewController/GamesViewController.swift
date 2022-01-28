//
//  AppsViewController.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit
import Alamofire

class GamesViewController: UIViewController {

   @IBOutlet var appsTable: UITableView!
   @IBOutlet var imageBarButton: UIBarButtonItem!

   var titlesArray = ["Popular","Featured"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      prepareTabBarItem()
      prepareForTable()
   }
   
   func prepareTabBarItem() {
      self.tabBarItem.image = UIImage(named: "games")
      self.navigationItem.largeTitleDisplayMode = .always
   }
   
   func prepareForTable() {
      self.appsTable.delegate = self
      self.appsTable.dataSource = self
      
      appsTable.register(UINib.init(nibName: "GamesFirstCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
      appsTable.register(UINib.init(nibName: "GamesSecondCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
   }
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      titlesArray.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.row == 0 {
         let cell = appsTable.dequeueReusableCell(withIdentifier: "FirstCell") as! GamesFirstCell
         cell.completion = { modelId in
            self.vcComplitionForCell(modelId: modelId)
         }
         return cell
      } else{
         let cell = appsTable.dequeueReusableCell(withIdentifier: "SecondCell") as! GamesSecondCell
         return cell
      }
   }
   
   func vcComplitionForCell(modelId: String?) {
      guard let vc = self.storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
      vc.gameId = modelId
      self.show(vc, sender: nil)
   }
 
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.row == 0 {
         return 275
      }
      return 250
   }
}

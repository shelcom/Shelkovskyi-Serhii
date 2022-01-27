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
   var oneGame: oneGameResponse?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      prepareTabBarItem()
      prepareForTable()
   }
   
   func prepareTabBarItem() {
      self.tabBarItem.image = UIImage(named: "apps")
      self.navigationItem.largeTitleDisplayMode = .always
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
         cell.completion = { modelId in
            self.vcComplitionForCell(modelId: modelId)
         }
         return cell
      } else{
         let cell = appsTable.dequeueReusableCell(withIdentifier: "SecondCell") as! AppsSecondCell
//         cell.titleLabel.text = titlesArray[indexPath.row-1]
//          cell.rowData = self.appdel.noOfRows?[indexPath.row-1]
         return cell
      }
   }
   
   func vcComplitionForCell(modelId: String?) {
      guard let vc = self.storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
      vc.gameId = modelId
      self.show(vc, sender: nil)
   }
   
//   func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//      if indexPath.row == 0 {
//         let cell = appsTable.dequeueReusableCell(withIdentifier: "FirstCell") as! AppsFirstCell
//         cell.imageView?.kf.cancelDownloadTask()
//         cell.setNeedsLayout()
//      } else {
//         let cell = appsTable.dequeueReusableCell(withIdentifier: "SecondCell") as! AppsSecondCell
//         cell.imageView?.kf.cancelDownloadTask()
//         cell.setNeedsLayout()
//      }
//   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.row == 0{
           return 275
       }
       return 250
   }
}

//
//  SecondCellCollectionView.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit
import Alamofire

class SecondCellCollectionView: UICollectionViewCell {
   
   @IBOutlet var tableInCollection: UITableView!
   
   var images: UIImage?
   var tableData : CollectionCellModel?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareTable()
   }
   
   func prepareTable() {
      self.tableInCollection.delegate = self
      self.tableInCollection.dataSource = self
      tableInCollection.register(UINib.init(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
   }
}

extension SecondCellCollectionView: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tableData?.applications?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let newCell = tableInCollection.dequeueReusableCell(withIdentifier: "FirstCell") as! FirstTableViewCell
      
      newCell.fill(model: tableData?.applications![indexPath.row])
      return newCell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 65
   }
   
   func tableView(tableView: UITableView, weightForRowAt indexPath: NSIndexPath) -> CGFloat {
       return self.tableInCollection.frame.width - 25
   }
}

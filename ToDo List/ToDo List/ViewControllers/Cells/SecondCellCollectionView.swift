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
   var manyBottomGames: [topGameResponse]?
   var id: Int?
   var imageRequestImageManager = RequestImageManager()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      self.tableInCollection.delegate = self
      self.tableInCollection.dataSource = self
      
      tableInCollection.register(UINib.init(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
   }
}

extension SecondCellCollectionView: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return manyBottomGames?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let newCell = tableInCollection.dequeueReusableCell(withIdentifier: "FirstCell") as! FirstTableViewCell
      
      let url = manyBottomGames?[id ?? 0].thumbnail! ?? ""
      newCell.newImageUIImage.setImage(imageUrl: url)
      newCell.newImageUIImage.kf.indicatorType = .activity
      newCell.newImageUIImage.contentMode = .scaleAspectFill
      newCell.newImageUIImage.layer.cornerRadius = 10
      
      newCell.titleLabel.text = manyBottomGames?[id ?? 0].title
      newCell.descriptionLabel.text = manyBottomGames?[id ?? 0].genre
      return newCell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60
   }
}

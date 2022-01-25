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
      
      let url = manyBottomGames?[indexPath.row].thumbnail! ?? ""
      imageRequestImageManager.downloadImage(with: url){image in
         self.images  = image
      }
      newCell.newImageUIImage.image = images
      newCell.newImageUIImage.contentMode = .scaleAspectFit
      
      newCell.titleLabel.text = manyBottomGames?[indexPath.row].title
      newCell.descriptionLabel.text = manyBottomGames?[indexPath.row].genre
      return newCell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60
   }
}

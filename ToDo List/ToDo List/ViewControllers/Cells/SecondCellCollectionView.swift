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
   var requestManager = RequestManager()
   var imageRequestImageManager = RequestImageManager()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      self.tableInCollection.delegate = self
      self.tableInCollection.dataSource = self
      
      tableInCollection.register(UINib.init(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
      gameForBottomRequest()
   }
   
   func gameForBottomRequest() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      
      let url = "https://free-to-play-games-database.p.rapidapi.com/api/games?platform=browser&category=mmorpg&sort-by=release-date"
      
      requestManager.requestForTopGame(headers: headers, url: url) { [self] response in
         manyBottomGames = response
         tableInCollection.reloadData()
      }
   }
}

extension SecondCellCollectionView: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
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




//class CollectionViewCellTwo: UICollectionViewCell,UITableViewDataSource, UITableViewDelegate{
//
//    var appDel = UIApplication.shared.delegate as! AppDelegate
//    var appData : [Application] = []
//    var ip : IndexPath?
//    var tableData : CollectionCellModel?
//
//    @IBOutlet weak var innerTable: UITableView!
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (tableData?.applications?.count)!
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let innerCell = innerTable.dequeueReusableCell(withIdentifier: "incell1") as! InnerTableViewCell
//        if (tableData?.applications?.count) != nil{
//            innerCell.appName.text = tableData?.applications![indexPath.row].trackCensoredName
//            innerCell.appDescription.text = tableData?.applications![indexPath.row].description
//            innerCell.selectionStyle = .none
//            innerCell.appIcon.imageFromURL(urlString: (tableData?.applications![indexPath.row].artworkUrl100!)!)
//        }
//        return innerCell
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 65
//    }
//
//
//}

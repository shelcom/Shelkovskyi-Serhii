//
//  SecondGameCell.swift
//  ToDoList
//
//  Created by Serhii on 24.01.2022.
//

import UIKit
import Alamofire

class SecondGameCell: UITableViewCell {

   @IBOutlet var bannerCollection: UICollectionView!
   
   var arrayScreenshotsString: [Screenshots]?
   var requestManager = RequestManager()
   var gameImage: UIImage?
   var gameId: Int?
   let headers: HTTPHeaders = [
      "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
      "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
   ]
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareCollection()
      getCurrentGameId()
      requestImages(id: gameId)
   }
   
   func getCurrentGameId() {
      let currentGameId = UserDefaults.standard.integer(forKey: "gameId")
      gameId = currentGameId
   }
   
   func requestImages(id: Int?) {
      if gameId != 0 {
         let url = "https://free-to-play-games-database.p.rapidapi.com/api/game?id=\(id ?? 0)"
         requestManager.requestOfOneGame(headers: headers, url: url){ [self] response in
            arrayScreenshotsString = response?.screenshots
            bannerCollection.reloadData()
         }
      }
   }
   
   func prepareCollection() {
      bannerCollection.delegate = self
      bannerCollection.dataSource = self
      bannerCollection.register(UINib.init(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
   }
}

extension SecondGameCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      gameId == 0 ? 0 : Int(arrayScreenshotsString?.count ?? 0)
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cellFirst = bannerCollection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! GameCollectionCell
      cellFirst.fill(model: arrayScreenshotsString?[indexPath.row])
      return cellFirst
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width:  self.bannerCollection.frame.width - 25, height: self.bannerCollection.frame.height)
   }
}

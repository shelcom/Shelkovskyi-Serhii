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
   var imageRequest = RequestImageManager()
   var requestManager = RequestManager()
   var gameImage: UIImage?
   var gameId: Int?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareCollection()
      let currentGameId = UserDefaults.standard.integer(forKey: "gameId")
      gameId = currentGameId
      requestImages(id: gameId)
   }
   
   func requestImages(id: Int?) {
      if gameId != 0 {
         let headers: HTTPHeaders = [
            "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
            "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
         ]
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
      let oneImage = arrayScreenshotsString?[indexPath.row].image
      let url = oneImage
      cellFirst.image.setImage(imageUrl: url ?? "")
      cellFirst.image.kf.indicatorType = .activity
      cellFirst.image.contentMode = .scaleAspectFill
      cellFirst.image.layer.cornerRadius = 6
      return cellFirst
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width:  self.bannerCollection.frame.width - 25, height: self.bannerCollection.frame.height)
   }
}

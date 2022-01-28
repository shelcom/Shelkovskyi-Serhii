//
//  AppsFirstCell.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit
import Alamofire
import Kingfisher

class GamesFirstCell: UITableViewCell {

   @IBOutlet var firstUICollection: UICollectionView!

   var images: UIImage?
   var manyTopGames: [manyGamesResponse]?
   var requestManager = RequestManager()
   let headers: HTTPHeaders = [
      "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
      "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
   ]
   let url = "https://free-to-play-games-database.p.rapidapi.com/api/games?platform=browser&category=mmorpg&sort-by=release-date"
   var completion: ((String) -> ())?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareUICollection()
      gameForTopRequest()
   }
   
   func prepareUICollection() {
      firstUICollection.delegate = self
      firstUICollection.dataSource = self
      firstUICollection.register(UINib.init(nibName: "FirstCellCollectionView", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionCell")
   }
   
   func gameForTopRequest() {
      requestManager.requestGames(headers: headers, url: url) { [self] response in
         manyTopGames = response
         firstUICollection.reloadData()
      }
   }
}

extension GamesFirstCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return manyTopGames?.count ?? 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cellFirst = firstUICollection.dequeueReusableCell(withReuseIdentifier: "FirstCollectionCell", for: indexPath) as! FirstCellCollectionView
      cellFirst.fill(model: manyTopGames?[indexPath.row])
      return cellFirst
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      completion?("\(manyTopGames?[indexPath.row].id ?? 0)" )
      UserDefaults.standard.setValue(manyTopGames?[indexPath.row].id ?? 0, forKey: "gameId")
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width:  self.firstUICollection.frame.width - 25, height: self.firstUICollection.frame.height)
   }
}

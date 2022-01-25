//
//  AppsFirstCell.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit
import Alamofire

class AppsFirstCell: UITableViewCell {

   @IBOutlet var firstUICollection: UICollectionView!

   var images: UIImage?
   var manyTopGames: [topGameResponse]?
   var requestManager = RequestManager()
   var imageRequestImageManager = RequestImageManager()
   var prov: Bool?
   var completion: ((String) -> ())?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      firstUICollection.delegate = self
      firstUICollection.dataSource = self
      firstUICollection.register(UINib.init(nibName: "FirstCellCollectionView", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionCell")
      
      gameForTopRequest()
   }
   
   func gameForTopRequest() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      
      let url = "https://free-to-play-games-database.p.rapidapi.com/api/games?platform=browser&category=mmorpg&sort-by=release-date"
      
      requestManager.requestForTopGame(headers: headers, url: url) { [self] response in
         manyTopGames = response
         firstUICollection.reloadData()
      }
   }
}

extension AppsFirstCell: UICollectionViewDelegate, UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return manyTopGames?.count ?? 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cellFirst = firstUICollection.dequeueReusableCell(withReuseIdentifier: "FirstCollectionCell", for: indexPath) as! FirstCellCollectionView
      
      let url = manyTopGames?[indexPath.row].thumbnail! ?? ""
      imageRequestImageManager.downloadImage(with: url){image in
         self.images  = image
      }
      cellFirst.imageView.image = images
      cellFirst.imageView.layer.cornerRadius = 10
      cellFirst.nameLabel.text = manyTopGames?[indexPath.row].title ?? ""
      cellFirst.categoryLabel.text = manyTopGames?[indexPath.row].genre ?? ""
      return cellFirst
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController")
      completion?("\(manyTopGames?[indexPath.row].id)" )
   }
   
   func perehod(completion: @escaping (_ proverka: Bool) -> Void) {
      if prov! {
         let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController")
         
      }
   }
}

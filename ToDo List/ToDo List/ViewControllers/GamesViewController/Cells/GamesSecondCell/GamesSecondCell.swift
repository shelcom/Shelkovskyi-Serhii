//
//  AppsSecondCell.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit
import Alamofire

class GamesSecondCell: UITableViewCell {

   @IBOutlet var secondCollectionView: UICollectionView!
   @IBOutlet var titleLabel: UILabel!
   
   var requestManager = RequestManager()
   var manyGames: [manyGamesResponse]?
   var gameController = GamesController()
   var rowData: TableRowModel?
   let headers: HTTPHeaders = [
      "x-rapidapi-host": "free-to-play-games-database.p.rapidapi.com",
      "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
   ]
   let url = "https://free-to-play-games-database.p.rapidapi.com/api/games?platform=browser&category=shooter&sort-by=release-date"
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      prepareCollectionView()
      gameForBottomRequest()
   }
   
   func prepareCollectionView() {
      secondCollectionView.delegate = self
      secondCollectionView.dataSource = self
      secondCollectionView.register(UINib.init(nibName: "SecondCellCollectionView", bundle: nil), forCellWithReuseIdentifier: "SecondCellCollection")
   }
   
   func gameForBottomRequest() {
      requestManager.requestGames(headers: headers, url: url) { [self] response in
         manyGames = response
         rowData = gameController.prepareData(gameArr: manyGames)
         secondCollectionView.reloadData()
      }
   }
}

extension GamesSecondCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return rowData?.collectionCells?.count ?? 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cellFirst = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondCellCollection", for: indexPath) as! SecondCellCollectionView
      cellFirst.tableData = rowData?.collectionCells![indexPath.row]
      return cellFirst
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 345, height: 200)
   }
}

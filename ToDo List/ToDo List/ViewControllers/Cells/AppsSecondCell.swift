//
//  AppsSecondCell.swift
//  ToDoList
//
//  Created by Serhii on 21.01.2022.
//

import UIKit

class AppsSecondCell: UITableViewCell {

   @IBOutlet var secondCollectionView: UICollectionView!
   @IBOutlet var titleLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      secondCollectionView.delegate = self
      secondCollectionView.dataSource = self
      secondCollectionView.register(UINib.init(nibName: "SecondCellCollectionView", bundle: nil), forCellWithReuseIdentifier: "SecondCellCollection")
   }
}

extension AppsSecondCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 8
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cellFirst = secondCollectionView.dequeueReusableCell(withReuseIdentifier: "SecondCellCollection", for: indexPath) as! SecondCellCollectionView
      return cellFirst
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 345, height: 200)
   }
}



//class TableViewCellTwo: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
//
//    @IBOutlet weak var sectionTitle: UILabel!
//    @IBOutlet weak var smallCollectionView: UICollectionView!
//    let appdel = UIApplication.shared.delegate as! AppDelegate
//    var rowData : TableRowModel?
//
//    @IBAction func seeAll(_ sender: Any) {
//    }
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        smallCollectionView.delegate = self
//        smallCollectionView.dataSource = self
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (rowData?.collectionCells?.count)!
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = smallCollectionView.dequeueReusableCell(withReuseIdentifier: "coll2", for: indexPath) as! CollectionViewCellTwo
//        cell.tableData = rowData?.collectionCells![indexPath.row]
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 345, height: 200)
//    }
//}

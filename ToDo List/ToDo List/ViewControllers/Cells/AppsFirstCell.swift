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
   
//   private func collectionView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
////         shouldPerformSegue(withIdentifier: "GameViewController", sender: indexPath.row)
////      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController")
////      vc.modalPresentationStyle = .overFullScreen
////      present(vc, animated: true, completion: nil)
//      print("hi")
//   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController")
//      prepareForSegue(segue: vc, sender: collectionView)
      
//      let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
//             vc?.image = UIImage(named: names[indexPath.row] )!
//             vc?.name = names[indexPath.row]
//      self.pushViewController(vc, animated: true)
//      prepare(for: vc, sender: indexPath)
      
   }
   
   func prepareForSegue(segue: UIViewController, sender: AnyObject!) {
//      if let cell = sender as? UICollectionViewCell {
////         let i = self.tableView.indexPath(for: cell)!.row
////         if segue.identifier == "toRestaurant" {
//            let vc = segue.destination as! GameViewController
//            vc.data = currentResponse[i] as NSDictionary
////         }
//      }
   }
   
//   func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//         if identifier != "fromLoginToTaskList" {
//            return true
//         }
//
//         let credentialController = CredentialsController(credentials: Credentials(email: emailTextField.text,
//                                                                                   password: passwordTextField.text))
//         do {
//            try credentialController.validate()
//            try credentialController.checkCredentials()
//            return true
//         } catch {
//            resultLabel.text = (error as! CredentialsError).description
//            return false
//         }
//      }

   func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "GameViewController" {
         guard let vc = segue.destination as? GameViewController else { return }
//         let currentUserId = UserDefaults.standard.integer(forKey: "currentUserId")
//         let note = findNote(sender: sender as! Int, currentUserId: currentUserId)
         vc.newString = "Fuck"
      }
   }

//extension UIResponder {
//    func next<T:UIResponder>(ofType: T.Type) -> T? {
//        let r = self.next
//        if let r = r as? T ?? r?.next(ofType: T.self) {
//            return r
//        } else {
//            return nil
//        }
//    }
}

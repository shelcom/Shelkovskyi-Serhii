//
//  requestImage.swift
//  ToDoList
//
//  Created by Serhii on 22.01.2022.
//

import Foundation
import Kingfisher

class RequestImageManager {
   
   func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void){
      guard let url = URL.init(string: urlString) else {
         return  imageCompletionHandler(nil)
      }
      let resource = ImageResource(downloadURL: url)
           
      KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
         switch result {
            case .success(let value):
               imageCompletionHandler(value.image)
            case .failure:
               imageCompletionHandler(nil)
         }
      }
   }
}

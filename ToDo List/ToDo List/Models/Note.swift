//
//  Note.swift
//  ToDo List
//
//  Created by Serhii on 07.12.2021.
//

import Foundation

struct Note: Codable {
   
   var id: Int
   var userId: Int
   var photo: Data?
   var title: String
   var text: String
   var date: Date
   var tag: tag.RawValue
   var favorites: Bool
}

enum tag: String {
   case allTag = "allTag"
   case firstTag = "firstTag"
   case secondTag = "secondTag"
}

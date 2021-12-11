//
//  NoteController.swift
//  ToDo List
//
//  Created by Serhii on 08.12.2021.
//

import Foundation
import UIKit

class NoteController {

   let defaults = UserDefaults.standard

   private var notes: [Note] {
      get {
         if let data = defaults.value(forKey: "notes") as? Data {
            return try! PropertyListDecoder().decode([Note].self, from: data)
         } else {
            return [Note]()
         }
      }
      set {
         guard let data = try? PropertyListEncoder().encode(newValue) else { return }
         defaults.set(data, forKey: "notes")
      }
   }
   
   private var tagNotes: [Note] = []
   private var searchNotes: [Note] = []

   func add(userId: Int, photo: Data, title: String, text: String) {
      let newNote = Note.init(userId: userId, photo: photo, title: title, text: text, date: Date(), tag: tag.firstTag.rawValue)
      notes.append(newNote)
   }
   
   func addTestNotes(userId: Int) {
      let testNote = Note.init(userId: userId, photo: nil, title: "First Note", text: "This is first Note.", date: Date(), tag: tag.firstTag.rawValue)
      notes.append(testNote)
   }
   
   func searchUserNotes(text: String, userId: Int) {
      searchNotes = []
      notesTitle(text: text, userId: userId)
   }
   
   func notesTitle(text: String, userId: Int) {
      _ = userNotes(userId: userId).map { note in
        if note.title.lowercased().contains(text.lowercased()) {
           searchNotes.append(note)
        }
      }
   }
   
   func filterNotesForTag(tag: String, userId: Int) {
      let userNotes = userNotes(userId: userId)
      let noteTag = userNotes.filter { note in
         note.tag == tag
      }
      tagNotes = noteTag
   }
   
   func notesCount(userId: Int) -> Int {
      userNotes(userId: userId).count
   }
   
   func searchNotesCount() -> Int {
      searchNotes.count
   }
   
   func note(by index: Int, userId: Int) -> Note {
      let userNote = userNotes(userId: userId)
      return userNote[index]
   }
   
   func searchNote(by index: Int) -> Note {
      searchNotes[index]
   }
   
   func remove(by index: Int) {
      notes.remove(at: index)
   }
   
   func userNotes(userId: Int) -> [Note] {
      let userNotes = notes.filter { note in
         note.userId == userId
      }
      return userNotes
   }
}

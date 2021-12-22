import Foundation
import UIKit

class NoteController {

   var defaults = UserDefaults.standard

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
   
   func add(userId: Int, photo: Data?, title: String, text: String, tag: String) -> Note {
      let newNote = Note.init(id: noteId(userId: userId), userId: userId, photo: photo ?? nil, title: title, text: text, date: Date(), tag: tag, favorites: false)
      notes.append(newNote)
      return newNote
   }
   
   func addTestNotes(userId: Int) {
      let photo = UIImage(named: "proba.png")!.pngData()
      let testNote = Note.init(id: noteId(userId: userId), userId: userId, photo: photo, title: "First Note", text: "This is first Note.", date: Date(), tag: tag.allTag.rawValue, favorites: false)
      notes.append(testNote)
   }
   
   func searchUserNotes(text: String, userId: Int) {
      searchNotes = []
      notesTitle(text: text, userId: userId)
   }
   
   func favoritesNote(userId: Int) -> [Note] {
      notes.filter { note in
         note.userId == userId && note.favorites == true
      }
   }
   
   func addFavoritesNote(title: String, userId: Int) {
      guard let indexFavoritesNote = notes.firstIndex(where: { $0.userId == userId && $0.title == title }) else { return }
      notes[indexFavoritesNote].favorites = true
   }
   
   func deleteFavoritesNote(title: String, userId: Int) {
      let index = searchIndex(array: notes, title: title, userId: userId)
      if index >= 0 {
         notes[index].favorites = false
      }
   }
   
   func searchIndex(array: [Note], title: String, userId: Int) -> Int {
      array.firstIndex(where: { $0.userId == userId && $0.title == title && $0.favorites == true })!
   }
   
   func favoritesNoteCount(userId: Int) -> Int {
      favoritesNote(userId: userId).count
   }
   
   func favoritesNoteByIndex(by index: Int, userId: Int) -> Note {
      favoritesNote(userId: userId)[index]
   }
   
   func checkTitleAndId(userId: Int, id: Int, title: String) -> Bool {
      (userNotes(userId: userId).filter { note in note.id != id }.firstIndex{ $0.title == title } != nil) ? true : false
   }
   
   func checkTitle(title: String) -> Bool {
      notes.firstIndex{ $0.title == title } != nil ? true : false
   }
   
   func notesTitle(text: String, userId: Int) {
      _ = userNotes(userId: userId).map { note in
        if note.title.lowercased().contains(text.lowercased()) {
           searchNotes.append(note)
        }
      }
   }
   
   func searchIndexNote(note: Note) -> Int {
      notes.firstIndex{ $0.id == note.id } ?? 1
   }
   
   func deleteNote(note: Note) {
      notes.remove(at: searchIndexNote(note: note))
   }
   
   func editNote(note: Note) {
      let index = searchIndexNote(note: note)
      notes[index] = note
   }
   
   func noteId(userId: Int) -> Int {
      let userNotes = userNotes(userId: userId)
      return userNotes.isEmpty ? 1 : (userNotes.last?.id ?? 0) + 1
   }
   
   func notesCount(userId: Int, tag: String) -> Int {
      let userNotes = userNotes(userId: userId)
      let noteTag = userNotes.filter { note in
         note.tag == tag
      }
      
      return noteTag.count
   }
   
   func searchNotesCount(userId: Int, searchText: String) -> Int {
      let userNotes = userNotes(userId: userId)
      var notes: [Note] = []
      userNotes.forEach { note in
         if note.title.lowercased().contains(searchText.lowercased()) {
            notes.append(note)
         }
      }
      return notes.count
   }
   
   func note(by index: Int, userId: Int, tag: String) -> Note {
      let userNotes = userNotes(userId: userId)
      let noteTag = userNotes.filter { note in
         note.tag == tag
      }
      tagNotes = noteTag
      return tagNotes[index]
   }
   
   func searchNote(by index: Int) -> Note {
      searchNotes[index]
   }
   
   func userNotes(userId: Int) -> [Note] {
      let userNotes = notes.filter { note in
         note.userId == userId
      }
      return userNotes
   }
}

//
//  EditNoteViewController.swift
//  ToDo List
//
//  Created by Serhii on 15.12.2021.
//

import UIKit

class EditNoteViewController: UIViewController {
   
   @IBOutlet var titleField: UITextField!
   @IBOutlet var photoButton: UIButton!
   @IBOutlet var textView: UITextView!
   @IBOutlet var tagSegment: UISegmentedControl!
   
   var note: Note? = nil
   var editingNote: Note? = nil
   var noteController = NoteController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fillData()
      hideKeyboard()
   }
   
   func hideKeyboard() {
      let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(tapGesture)
   }
   
   @objc func endEditing() {
      view.endEditing(true)
   }
   
   func fillData() {
      titleField.text = note?.title ?? ""
      guard let photo = note?.photo else { return }
      let image = UIImage(data: photo)
      photoButton.setImage(image, for: .normal)
      textView.text = note?.text ?? ""
      tagSegment.selectedSegmentIndex = setTagSegment()
   }
   
   @IBAction func editPhoto(_ sender: Any) {
      let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { (handler) in
         self.openCamera() }  ))
      alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (handler) in
         self.openGallery() }  ))
      alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: { (handler) in }))
      present(alert, animated: true, completion: nil)
   }
   
   func openGallery() {
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
         let image = UIImagePickerController()
         image.allowsEditing = true
         image.delegate = self
         self.present(image, animated: true, completion: nil)
      } else {
         let alert = UIAlertController(title: "Warning", message: "You don't photo Library", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
      }
   }
   
   func openCamera() {
      if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
         let imagePicker = UIImagePickerController()
         imagePicker.sourceType = UIImagePickerController.SourceType.camera
         imagePicker.allowsEditing = false
         imagePicker.delegate = self
         self.present(imagePicker, animated: true, completion: nil)
      } else {
         let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
      }
   }
   
   func setTagSegment() -> Int {
      let noteTag = note?.tag ?? ""
      switch noteTag {
      case tag.allTag.rawValue:
         return 0
      case tag.firstTag.rawValue:
         return 1
      default:
         return 2
      }
   }
   
   @IBAction func pressButton(_ sender: Any) {
      checkEditingNote()
      
      if titleField.text?.isEmpty != true {
         let userId = UserDefaults.standard.integer(forKey: "currentUserId")
         if noteController.checkTitleAndId(userId: userId, id: note!.id, title: titleField.text ?? "") {
            alert(title: "Error", message: "Titile not uniq")
         } else {
            guard let pasteNote = note else { return }
            alertForEditNote(note: pasteNote)
         }
      } else {
         alert(title: "Error", message: "Titile is Empty")
      }
   }
   
   func checkEditingNote() {
      note?.title = titleField.text ?? ""
      note?.text = textView.text ?? ""
      note?.photo = photoButton.currentImage != nil ? photoButton.currentImage!.pngData() : nil
      note?.tag = decodeTagSegment(tagIndex: tagSegment.selectedSegmentIndex)
   }
   
   func decodeTagSegment(tagIndex: Int) -> String {
      switch tagIndex {
         case 0:
            return tag.allTag.rawValue
         case 1:
            return tag.firstTag.rawValue
         default:
            return tag.secondTag.rawValue
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.tabBarController?.tabBar.isHidden = true
      self.tabBarController?.tabBar.layer.zPosition = -1
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.tabBarController?.tabBar.isHidden = false
      self.tabBarController?.tabBar.layer.zPosition = -0
   }
}

extension EditNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      let data = convertFromUIimageToDict(info)
      
      if let editingImage = data[convertInfoKey((UIImagePickerController.InfoKey.editedImage))] as? UIImage {
         photoButton.setImage(editingImage, for: .normal)
         picker.dismiss(animated: true, completion: nil)
      }
      
      if let pickedImage = (info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage?) {
         photoButton.setImage(pickedImage, for: .normal)
         picker.dismiss(animated: true, completion: nil)
      }
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      picker.dismiss(animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      self.dismiss(animated: true, completion: nil)
   }
   
   func convertFromUIimageToDict(_ input: [UIImagePickerController.InfoKey : Any]) -> [String : Any] {
      return Dictionary(uniqueKeysWithValues: input.map({ key, value in
         (key.rawValue, value)
      }))
   }
   
   func convertInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
      return input.rawValue
   }
}

//
//  CreateNoteViewController.swift
//  ToDo List
//
//  Created by Serhii on 07.12.2021.
//

import UIKit
import MobileCoreServices

class CreateNoteViewController: UIViewController {
   
   @IBOutlet var titleTextField: UITextField!
   @IBOutlet var textUITextView: UITextView!
   @IBOutlet var photoButton: UIButton!
   
   let noteController = NoteController()
   var photo: Data? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   @IBAction func addPhoto(_ sender: Any) {
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
   
   @IBAction func addNote(_ sender: Any) {
      guard let photo = photoButton.currentImage!.pngData() else { return }
      noteController.add(userId: UserDefaults.standard.integer(forKey: "currentUserId"), photo: photo, title: titleTextField.text ?? "", text: textUITextView.text ?? "")
   }
}

extension CreateNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
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

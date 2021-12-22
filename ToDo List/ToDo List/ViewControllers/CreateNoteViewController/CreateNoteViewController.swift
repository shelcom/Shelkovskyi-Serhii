//
//  CreateNoteViewController.swift
//  ToDo List
//
//  Created by Serhii on 07.12.2021.
//

import UIKit
import MobileCoreServices
import UserNotifications

class CreateNoteViewController: UIViewController {
   
   @IBOutlet var titleTextField: UITextField!
   @IBOutlet var textUITextView: UITextView!
   @IBOutlet var photoButton: UIButton!
   @IBOutlet var tagSegment: UISegmentedControl!
   
   let noteController = NoteController()
   var photo: Data? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
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
         let alert = UIAlertController(title: "Warning", message: "You don't have photo Library", preferredStyle: .alert)
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
      if let newNote = newNote() {
         notificationAllert(note: newNote)
      }
   }
   
   func newNote() -> Note? {
      if titleTextField.text?.isEmpty != true {
         if noteController.checkTitle(title: titleTextField.text ?? "") {
            alert(title: "Error", message: "Titile not uniq")
            return nil
         } else {
            let photo = photoButton.currentImage != nil ? photoButton.currentImage!.pngData() : nil
            return noteController.add(userId: UserDefaults.standard.integer(forKey: "currentUserId"), photo: photo, title: titleTextField.text ?? "", text: textUITextView.text ?? "", tag: decodeTagSegment(tagIndex: tagSegment.selectedSegmentIndex))
         }
      } else {
         alert(title: "Error", message: "Titile is Empty")
         return nil
      }
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "NotificationViewController" {
         guard let vc = segue.destination as? NotificationViewController else { return }
         vc.note = sender as? Note
      }
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

extension CreateNoteViewController {
   
   func notificationAllert(note: Note) {
      let alert = UIAlertController(title: "Create Notification", message: nil, preferredStyle: .alert)

      let yesAction = UIAlertAction(title: "Yes, create", style: .default) { (action) in
         self.performSegue(withIdentifier: "NotificationViewController", sender: note)
      }

      let noAction = UIAlertAction(title: "No", style: .destructive) { (action) in
         let storyBoard: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
         let vC = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
         self.show(vC, sender: nil)
      }
      
      alert.addAction(yesAction)
      alert.addAction(noAction)
      self.present(alert, animated: true, completion: nil)
   }
}

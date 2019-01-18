//
//  DetailViewController.swift
//  PhotoJournalProject
//
//  Created by Alfredo Barragan on 1/15/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var function: Function!
    var newImage = UIImage()
    var indexChosen = Int()
    var chosenImage = Bool()
    private var imagePickerViewController: UIImagePickerController!
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var imageTextView: UITextView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpSaveButton()
        saveButton.isEnabled = false
        imageTextView.delegate = self
        imageTextView.text = "Enter Title"
        imageTextView.textColor = .lightGray
        if function == .edit{
            saveButton.isEnabled = false
            cameraButton.isEnabled = false
            photoLibraryButton.isEnabled = false
            addImage.image = newImage
        }
        setupImagePickerViewController()
    }
    
    private func setupImagePickerViewController(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraButton.isEnabled = false
        }
    }
    private func showImagePickerController() {
        present(imagePickerViewController,animated: true,completion:  nil)
    }
    private func popUpSaveButton(){
        if imageTextView.text != nil{
            if chosenImage || function == .edit{
                saveButton.isEnabled = true
            }
        }
    }
    @IBAction func cameraButtonWasPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .camera
        showImagePickerController()
    }
    @IBAction func photoLibraryButtonWasPressed(_ sender: UIBarButtonItem) {
        showImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
    }
    @IBAction func saveButtonWasPressed(_ sender: UIBarButtonItem) {
        guard let photoDescription = imageTextView.text else {fatalError("no title")}
        if let imageData = newImage.jpegData(compressionQuality: 0.5) {
            let date = Date()
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone, .withInternetDateTime, .withDashSeparatorInDate]
            let timestamp = isoDateFormatter.string(from: date)
            let photo = Photo.init(created: timestamp, imageData: imageData, description: photoDescription)
            if function == .add{
                PhotoModel.addPhotoFunction(photo: photo)
            }
            if function == .edit{
                PhotoModel.editFunction(item: photo, atIndex: indexChosen)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonWasPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addImage.image = image
            newImage = image
            chosenImage = true
            popUpSaveButton()
            
        } else {
            print("no image brah")
        }
        dismiss(animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
        popUpSaveButton()
    }
}

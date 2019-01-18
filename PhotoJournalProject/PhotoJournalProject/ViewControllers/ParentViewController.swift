//
//  ViewController.swift
//  PhotoJournalProject
//
//  Created by Alfredo Barragan on 1/15/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    @IBOutlet weak var photoJournalCollection: UICollectionView!
    
    var photos = [Photo]() {
        didSet {
            photoJournalCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        photoJournalCollection.dataSource = self
        photoJournalCollection.delegate = self
    }
    @IBAction func addButtonWasPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddPhotos") as? ViewController else {return}
        vc.function = .add
        present(vc, animated: true, completion: nil)
    }
    
    func reload(){
        photos = PhotoModel.getPhotosFunction()
        photoJournalCollection.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoJournalCollection.reloadData()
        photos = PhotoModel.getPhotosFunction()
    }
    
    
}

extension ParentViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell else {return UICollectionViewCell()}
        let photoToSet = photos[indexPath.row]
        cell.cellDescription.text = photoToSet.description
        cell.cellDate.text = photoToSet.dateFormattedString
        cell.cellButton.tag = indexPath.row
        let image = UIImage(data: photoToSet.imageData)
        cell.cellImage.image = image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:300, height:450)
        
    }
    
}

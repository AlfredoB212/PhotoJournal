//
//  PhotoModel.swift
//  PhotoJournalProject
//
//  Created by Alfredo Barragan on 1/18/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import Foundation
final class PhotoModel {
    static var photos = [Photo]()
    private static let filename = "PhotoList.plist"
    private init () {}
    
    static func addPhotoFunction(photo: Photo){
        photos.append(photo)
        saveFunction()
    }
    static func saveFunction(){
        let path = DataPersistanceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photos)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error \(error)")
        }
    }
    static func deleteFunction(item: Photo, atIndex index: Int){
        photos.remove(at: index)
        saveFunction()
    }
    static func editFunction(item: Photo, atIndex index: Int) {
        photos.remove(at: index)
        photos.insert(item, at: index)
        saveFunction()
    }
    static func getPhotosFunction() -> [Photo]{
        let path = DataPersistanceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do {
                    photos = try PropertyListDecoder().decode([Photo].self, from: data)
                    photos = photos.sorted{$0.date > $1.date}
                }catch{
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return photos
    }
}

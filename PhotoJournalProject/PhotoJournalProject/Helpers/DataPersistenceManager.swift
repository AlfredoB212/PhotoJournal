//
//  DataPersistenceManager.swift
//  PhotoJournalProject
//
//  Created by Alfredo Barragan on 1/18/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import Foundation
final class DataPersistanceManager {
    private static let filename = "PhotoList.plist"
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}

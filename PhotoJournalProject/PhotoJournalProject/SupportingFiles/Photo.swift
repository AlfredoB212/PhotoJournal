//
//  Photo.swift
//  PhotoJournalProject
//
//  Created by Alfredo Barragan on 1/18/19.
//  Copyright © 2019 Alfredo Barragan. All rights reserved.
//

import Foundation
struct Photo: Codable {
    let created: String
    let imageData: Data
    let description: String
    
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = created
        if let date = isoDateFormatter.date(from: created) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    public var date: Date{
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: created) {
            formattedDate = date
        }
        return formattedDate
    }
}

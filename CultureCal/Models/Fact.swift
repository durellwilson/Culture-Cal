//
//  File.swift
//  CultureCal
//
//  Created by Durell Wilson on 3/12/24.
//

import Foundation

struct Fact: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let content: String
    let date: String // Keep the property as a string
    
    // Rest of the struct implementation...
    
    var formattedDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.date(from: date)
    }
}

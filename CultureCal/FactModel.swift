//
//  FactModel.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/26/23.
//

import Foundation

struct Fact {
    let title: String
    let content: String
    let date: Date?


// Usage:
if let factDate = fact.date {
    Text(dateFormatter.string(from: factDate))
} else {
    Text("No Date Available")
}

    
    static func == (lhs: Fact, rhs: Fact) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

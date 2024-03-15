//
//  Book.swift
//  CultureCal
//
//  Created by Durell Wilson on 3/12/24.
//

import Foundation

struct Book: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    let story: String
}

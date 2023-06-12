//
//  DataSource.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/18/23.
//

import Foundation

struct DataSource {
    static func facts() -> [String: Fact] {
        var dataSource = [String: Fact]
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd"
            return formatter
        }()
        
        // Add facts using dates
        dataSource[dateFormatter.string(from: Date(timeIntervalSince1970: 1610782800))] = Fact(title: "18th Amendment Ratified", content: "On this day in 1920, the 18th Amendment to the United States Constitution was ratified, prohibiting the production, sale, and transportation of alcoholic beverages.")
        dataSource[dateFormatter.string(from: Date(timeIntervalSince1970: 1610869200))] = Fact(title: "Charlotte E. Ray", content: "On this day in 1871, Charlotte E. Ray became the first African American woman to be admitted to the bar and practice law in the United States.")
        // Add more dates and facts here
        
        return dataSource
    }
}

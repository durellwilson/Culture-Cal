//
//  MonthView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/26/23.
//

import Foundation
import SwiftUI

struct MonthView: View {
    let month: Int
    @Binding var selectedMonth: Int?
    let months: [String]
    
    var body: some View {
        VStack {
            Text(months[month - 1])
                .font(.title2)
                .foregroundColor(month == selectedMonth ? .white : Color("FistGreen"))
                .onTapGesture {
                    selectedMonth = month == selectedMonth ? nil : month
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(month == selectedMonth ? Color("FistGreen") : .clear)
                )
        }
    }
}

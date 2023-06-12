//
//  QuoteCardView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuoteCardView: View {
    let quote: Quote
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quote.text)
                .font(.headline)
            
            Text("- \(quote.author)")
                .font(.caption)
                .foregroundColor(Color(.secondaryLabel))
            
            Image(quote.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            Text(quote.additionalInfo)
                .font(.subheadline)
                .foregroundColor(Color(.secondaryLabel))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
    }
}


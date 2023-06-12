//
//  QuizCardView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuizCardView: View {
    let quiz: Quiz
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quiz.question)
                .font(.headline)
            
            Text("Tap to Answer")
                .font(.caption)
                .foregroundColor(Color(.secondaryLabel))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
    }
}



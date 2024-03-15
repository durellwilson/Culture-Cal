//
//  QuizCardView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuizCardView: View {
    var quiz: Quiz
    
    var body: some View {
        VStack {
            Text(quiz.question)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color("FistGreen"))
                .cornerRadius(10)
            
            if quiz.isAnswered {
                Text(quiz.isAnsweredCorrectly ? "Correct!" : "Incorrect!")
                    .font(.subheadline)
                    .foregroundColor(quiz.isAnsweredCorrectly ? .green : .red)
                    .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}


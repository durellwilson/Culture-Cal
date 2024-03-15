//
//  QuizRowView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuizRowView: View {
    var quizState: QuizState
    @State private var userAnswer: String = ""
    @State private var isCorrect: Bool = false
    @Binding var correctAnswers: Int
    @Binding var quizStates: [QuizState] // Add quizStates binding
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quizState.quiz.question)
                .font(.headline)
            
            TextField("Type your answer", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                // Check user's answer here
                checkAnswer()
            }) {
                Text("Submit Answer")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                    )
            }
            
            if isCorrect {
                Text("Correct Answer!")
                    .font(.subheadline)
                    .foregroundColor(.green)
            } else if quizState.isAnswered {
                Text("Question Answered!")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            
            Divider()
        }
        .padding(.vertical, 8)
    }
    
    private func checkAnswer() {
        if !quizState.isAnswered {
            isCorrect = userAnswer.lowercased() == quizState.quiz.answer.lowercased()
            if isCorrect {
                correctAnswers += 1
                
                if let index = quizStates.firstIndex(where: { $0.quiz.id == quizState.quiz.id }) {
                    quizStates[index].isAnswered = true
                }
            }
        }
    }
}



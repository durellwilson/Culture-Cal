//
//  QuizDetailView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuizDetailView: View {
    var quiz: Quiz
    @Binding var totalQuestions: Int
    @Binding var correctAnswers: Int
    @State private var userAnswer = ""
    @State private var isAnswerCorrect = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 16) {
            Text(quiz.question)
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Enter your answer", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: checkAnswer) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("FistGreen"))
                    .cornerRadius(10)
            }
            .disabled(userAnswer.isEmpty || isAnswerCorrect)
            
            Text(isAnswerCorrect ? "Correct!" : "Incorrect!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(isAnswerCorrect ? .green : .red)
            
            Text("Score: \(correctAnswers)/\(totalQuestions)")
                .font(.headline)
                .foregroundColor(Color("FistGreen"))
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            userAnswer = ""
            isAnswerCorrect = false
        }
    }
    
    private func checkAnswer() {
        isAnswerCorrect = userAnswer.lowercased() == quiz.answer.lowercased()
        if isAnswerCorrect {
            correctAnswers += 1
        }
        totalQuestions -= 1
    }
}



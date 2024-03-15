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
    @State private var userAnswer = ""
    @State private var isAnswerCorrect: Bool?
    @State private var score = UserDefaults.standard.integer(forKey: "QuizScore")
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
            
            if let isAnswerCorrect = isAnswerCorrect {
                Text(isAnswerCorrect ? "Correct!" : "Incorrect!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(isAnswerCorrect ? .green : .red)
            }
            
            Text("Score: \(calculateScore())%")
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
            isAnswerCorrect = nil
        }
    }
    
    private func checkAnswer() {
        guard !userAnswer.isEmpty else { return }
        
        let lowercasedUserAnswer = userAnswer.lowercased()
        let lowercasedCorrectAnswer = quiz.answer.lowercased()
        
        isAnswerCorrect = lowercasedUserAnswer == lowercasedCorrectAnswer
        
        if isAnswerCorrect == true {
            score += 1
            UserDefaults.standard.set(score, forKey: "QuizScore")
        }
        
        totalQuestions -= 1
    }
    
    private func calculateScore() -> Int {
        let percentage = Double(score) / Double(totalQuestions) * 100
        return Int(percentage)
    }
}

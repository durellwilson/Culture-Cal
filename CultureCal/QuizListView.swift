//
//  QuizListView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct Quiz: Identifiable ,Equatable {
    let id = UUID()
    let question: String
    let answer: String
    var isAnswered: Bool = false // New property
    var isAnsweredCorrectly: Bool = false
}

struct QuizState {
        var quiz: Quiz
        var isAnswered: Bool = false
    }

struct QuizListView: View {
    var quizzes: [Quiz] = [
        Quiz(question: "Who was the first African American President of the United States?", answer: "Barack Obama"),
        Quiz(question: "Who is often referred to as the 'Mother of the Civil Rights Movement'?", answer: "Rosa Parks"),
        Quiz(question: "Who wrote the famous poem 'I Know Why the Caged Bird Sings'?", answer: "Maya Angelou"),
        Quiz(question: "Who was the first African American to win an Academy Award for Best Actor?", answer: "Sidney Poitier"),
        Quiz(question: "Who is the author of the book 'To Kill a Mockingbird'?", answer: "Harper Lee"),
        Quiz(question: "Who was the first African American woman to be crowned Miss America?", answer: "Vanessa Williams"),
        Quiz(question: "Who was the first African American astronaut?", answer: "Guion Bluford"),
        Quiz(question: "Who is known for the invention of the traffic light?", answer: "Garrett Morgan"),
        Quiz(question: "Who was the first African American woman to win the Nobel Prize in Literature?", answer: "Toni Morrison"),
        Quiz(question: "Who is the first African American woman to serve as the United States Vice President?", answer: "Kamala Harris"),
        Quiz(question: "Who is the first African American woman to win the Nobel Peace Prize?", answer: "Ralph Bunche"),
        Quiz(question: "Who was an influential jazz pianist and composer known as the 'King of Ragtime'?", answer: "Scott Joplin"),
        Quiz(question: "Who is the first African American billionaire?", answer: "Robert L. Johnson"),
        Quiz(question: "Who was the first African American Supreme Court Justice?", answer: "Thurgood Marshall"),
        Quiz(question: "Who is the first African American woman to be elected to the United States Congress?", answer: "Shirley Chisholm"),
        Quiz(question: "Who is known for the invention of the portable X-ray machine?", answer: "Dr. Charles Richard Drew"),
        Quiz(question: "Who was a prominent abolitionist and author of the autobiography 'Narrative of the Life of Frederick Douglass'?", answer: "Frederick Douglass"),
        Quiz(question: "Who is the first African American woman to win an Olympic gold medal?", answer: "Alice Coachman"),
        Quiz(question: "Who is known for the invention of the gas mask?", answer: "Garrett Morgan"),
        Quiz(question: "Who was a prominent singer and civil rights activist known as the 'Queen of Soul'?", answer: "Aretha Franklin"),
        Quiz(question: "Who is the first African American to win a Tony Award for Best Actor in a Play?", answer: "James Earl Jones"),
        Quiz(question: "Who is known for the invention of the Super Soaker water gun?", answer: "Lonnie Johnson"),
        Quiz(question: "Who was the first African American woman to be crowned Miss Universe?", answer: "Janelle Commissiong"),
        Quiz(question: "Who is known for the invention of the automatic elevator door?", answer: "Alexander Miles"),
        Quiz(question: "Who was the first African American woman to win an Academy Award for Best Actress?", answer: "Halle Berry"),
        Quiz(question: "Who is known for the invention of the home security system?", answer: "Marie Van Brittan Brown"),
        Quiz(question: "Who was a prominent African American poet and author of the poem 'Still I Rise'?", answer: "Maya Angelou"),
        Quiz(question: "Who is the first African American to win the Nobel Prize in Literature?", answer: "Toni Morrison"),
        Quiz(question: "Who was the first African American woman to win an Olympic gold medal in track and field?", answer: "Wilma Rudolph"),
        Quiz(question: "Who is known for the invention of the modern traffic light?", answer: "Garrett Morgan")
    ]
    
    @State private var selectedQuiz: Quiz?
        @State private var totalQuestions: Int = 0
        @State private var correctAnswers: Int = 0
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(quizzes) { quiz in
                            QuizCardView(quiz: quiz)
                                .onTapGesture {
                                    selectedQuiz = quiz
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .background(Color(.systemGray6))
                .navigationBarTitle("Legacy Quiz")
                .navigationBarHidden(false)
            }
            .sheet(item: $selectedQuiz) { quiz in
                QuizDetailView(
                    quiz: quiz,
                    totalQuestions: $totalQuestions
                )
            }
            .onAppear {
                totalQuestions = quizzes.count
                correctAnswers = 0
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            })
        }
    }
struct QuizListView_Previews: PreviewProvider {
    static var previews: some View {
        QuizListView()
    }
}

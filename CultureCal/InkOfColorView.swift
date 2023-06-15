//
//  InkofColorView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/14/23.
//

import SwiftUI

struct InkOfColorView: View {
    @State private var selectedBook: Book?
    @Environment(\.presentationMode) var presentationMode
    
    let books: [Book] = [
        Book(name: "The Warmth of Other Suns", imageName: "The Warmth of Other Suns", story: "The Warmth of Other Suns by Isabel Wilkerson is a powerful and deeply moving work that delves into the Great Migration, one of the most significant events in American history. Through extensive research and poignant storytelling, Wilkerson traces the experiences of three individuals who embarked on separate journeys from the South to the North and West, seeking a better life and freedom from racial oppression. This epic narrative offers a profound understanding of the struggles, hopes, and dreams of African Americans during a transformative period in the 20th century. Wilkerson's meticulous attention to detail and her ability to capture the emotional essence of her subjects make this book a captivating and essential read for anyone interested in understanding the complexities of race, migration, and the enduring human spirit."),
        Book(name:"Up from Nothing", imageName: "Up from Nothing", story: "Up from Nothing by John Hope Bryant is an inspiring and thought-provoking book that explores the power of financial literacy and entrepreneurship as tools for personal and community empowerment. Drawing from his own life experiences and those of successful individuals he has encountered, Bryant shares valuable insights on how to overcome adversity, build wealth, and create opportunities even when starting with nothing. With a compelling blend of personal anecdotes, practical advice,and social commentary, Bryant's book serves as a rallying cry for economic empowerment and a roadmap for those seeking to rise above their circumstances and achieve financial freedom. Up from Nothing is a compelling read that encourages readers to dream big, take action, and believe in the transformative power of entrepreneurship."),
        Book(name:"You Owe You", imageName: "You Owe You", story: "You Owe You by Eric Thomas, P.H.D., is a motivational and empowering book that challenges readers to take full responsibility for their lives and embrace their own potential. With his signature passion and enthusiasm, Thomas shares his personal journey from adversity to success, and offers practical strategies for personal growth and self-mastery. Through powerful anecdotes, insightful teachings, and actionable advice, he emphasizes the importance of owning one's choices, dreams, and actions, and empowers readers to become the architects of their own destiny. You Owe You is a transformative read that inspires individuals to tap into their inner strength, unleash their true potential, and create a life filled with purpose and success. It serves as a powerful reminder that the power to change lies within oneself and encourages readers to seize control of their lives and make a lasting impact."),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(books) { book in
                    Button(action: {
                        toggleSelectedBook(book)
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            
                            HStack(spacing: 16) {
                                Image(book.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(book.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    if selectedBook != book {
                                        Text(book.story)
                                            .font(.body)
                                            .lineLimit(3)
                                    }
                                }
                            }
                            .padding(16)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if let selectedBook = selectedBook, selectedBook == book {
                        VStack {
                            Image(book.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                            
                            Text(book.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(book.story)
                                .font(.body)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Ink of Color")
        .foregroundColor(Color("FistGreen"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        }
                            )}
    private func toggleSelectedBook(_ book: Book) {
        if selectedBook == book {
            selectedBook = nil
        } else {
            selectedBook = book
        }
    }
}

struct Book: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    let story: String
}


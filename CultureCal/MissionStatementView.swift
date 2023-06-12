//
//  SwiftUIView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/25/23.
//
import SwiftUI

struct MissionStatementView: View {
    @State private var isCalendarViewPresented = false
    
    let missionStatement: String = """
    At CultureCal, our mission is to celebrate black achievement and illuminate history-changing events by highlighting the rich culture and contributions of black individuals. Our app offers a sleek and interactive calendar experience, combining simplicity and fun. Discover historical events, birthdays of influential black celebrities and leaders, and important cultural milestones. CultureCal is your gateway to immerse yourself in the vibrant tapestry of black history and celebrate the remarkable accomplishments that have shaped our world.
    """
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Image("Fist")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.top, 48)
                        .onTapGesture {
                            isCalendarViewPresented = false
                        }
                        .foregroundColor(Color("FistGreen"))
                    
                    Text("Our Mission")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("FistGreen"))
                    
                    ScrollView {
                        Text(missionStatement)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(Color("FistGreen"))
                    }
                        
                        // ListView
                        List {
                            NavigationLink(destination: QuoteListView(quotes: quotes)) {
                                MissionStatementButton(title: "Discover Famous Quotes")
                            }
                            
                            NavigationLink(destination: QuizListView()) {
                                MissionStatementButton(title: "Black History Quizzes")
                            }
                            
                            NavigationLink(destination: QuoteListView(quotes: quotes)) {
                                MissionStatementButton(title: "Our Mission")
                            }
                            
                            NavigationLink(destination:QuoteListView(quotes: quotes)) {
                                MissionStatementButton(title: "Celebrate Black Innovators")
                            }
                            
                            NavigationLink(destination:QuoteListView(quotes: quotes)) {
                                MissionStatementButton(title: "Book Reviews")
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .foregroundColor(Color("FistGreen"))
                        .padding(.vertical, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.white)
                            .shadow(color: Color(.systemGray4), radius: 8, x: 0, y: 2)
                    )
                    .padding()
                    .animation(.spring())
                }
                .navigationBarBackButtonHidden(true)
                .foregroundColor(Color("FistGreen"))// Hide the back button
            }
        }
    }
    
    struct MissionStatementButton: View {
        let title: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
        }
    }

    struct Quiz: Identifiable {
        let id = UUID()
        let question: String
        let answer: String
        var isAnswered: Bool = false // New property
    }
    
struct QuizState {
        var quiz: Quiz
        var isAnswered: Bool = false
    }
    

    struct MissionStatementView_Previews: PreviewProvider {
        static var previews: some View {
            MissionStatementView()
        }
    }


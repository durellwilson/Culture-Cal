//
//  FactListView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/25/23.
//
import SwiftUI
import Foundation
import CoreData

struct FactListView: View {
    let facts: [Fact]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()
    struct Quote: Identifiable {
            let id = UUID()
            let text: String
            let author: String
        }
    @Binding var isPresented: Bool
    @Binding var selectedFact: Fact?
    @State private var favoriteFacts: Set<Fact> = Set<Fact>()
    @State private var selectedMonth: Int?
    @State private var searchText: String = ""
    @State private var isSheetPresented = false
    @State private var quotes: [Quote] = [
            Quote(text: "Quote 1", author: "Author 1"),
            Quote(text: "Quote 2", author: "Author 2"),
            // Add more quotes here...
        ]
    
    private let months: [String] = Calendar.current.monthSymbols.map { $0.capitalized }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(1..<13) { month in
                            MonthView(month: month, selectedMonth: $selectedMonth, months: months)
                                .onTapGesture {
                                    selectedMonth = month
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                List(getFilteredFacts(), id: \.self) { fact in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("\(fact.title) - \(dateFormatter.string(from: fact.formattedDate ?? Date()))")
                                .font(.headline)
                                .foregroundColor(Color("FistGreen"))
                                .onTapGesture {
                                    withAnimation {
                                        selectedFact = fact
                                    }
                                }
                            
                      //      Spacer()
                            
                      //      if favoriteFacts.contains(fact) {
                     //           Image(systemName: "star.fill")
                      //              .foregroundColor(.yellow)
                      //              .onTapGesture {
                      //                  toggleFavoriteFact(fact)
                       //             }
                         //   } else {
                         //       Image(systemName: "star")
                         //           .foregroundColor(.gray)
                          //          .onTapGesture {
                           //             toggleFavoriteFact(fact)
                            //        }
                           // }
                        }
                        
                        if selectedFact == fact {
                            Text(fact.content)
                                .font(.subheadline)
                                .foregroundColor(.green)
                                .transition(.opacity)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.green.opacity(0.1))
                            .padding(.horizontal, -16)
                    )
                }
            }
            
            .navigationBarTitle(Text("Historical Events"))
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }) {
                Text("Done")
                    .foregroundColor(Color("FistGreen"))
            })
            .sheet(item: $selectedFact) { fact in
                if let date = fact.formattedDate {
                    let formattedDate = dateFormatter.string(from: date)
                    FactSheet(fact: fact, dateFormatter: dateFormatter, isPresented: $isPresented)
                } else {
                    EmptyView()
                }
            }
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        .animation(.default)
    }
    
    private func getFilteredFacts() -> [Fact] {
        let filteredFacts = facts.filter { fact in
            if let selectedMonth = selectedMonth {
                let monthComponents = Calendar.current.dateComponents([.month], from: fact.formattedDate ?? Date())
                return monthComponents.month == selectedMonth
            } else {
                return true
            }
        }
        .filter { fact in
            return searchText.isEmpty || fact.title.localizedCaseInsensitiveContains(searchText)
        }
        .sorted { fact1, fact2 in
            let date1 = fact1.formattedDate ?? Date()
            let date2 = fact2.formattedDate ?? Date()
            return date1 < date2
        }
        return filteredFacts
    }
    
    private func toggleFavoriteFact(_ fact: Fact) {
        if favoriteFacts.contains(fact) {
            favoriteFacts.remove(fact)
        } else {
            favoriteFacts.insert(fact)
        }
    }
}

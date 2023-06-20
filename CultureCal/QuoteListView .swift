//
//  QuoteListView .swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuoteListView: View {
    let quotes: [Quote]
    @State private var selectedQuote: Quote?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(quotes) { quote in
                    Button(action: {
                        toggleSelectedQuote(quote)
                    }) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 16) {
                                Image(quote.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                Text(quote.author)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .scaledToFit()
                                    .lineLimit(1)
                            }
                            if selectedQuote != quote {
                                Text(quote.text)
                                    .font(.body)
                                    .lineLimit(3)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if let selectedQuote = selectedQuote, selectedQuote == quote {
                        VStack {
                            Image(quote.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                            
                            VStack {
                                Text(quote.text)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                
                                Text(quote.additionalInfo)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Quotes")
        .foregroundColor(Color("FistGreen"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        })
    }
    
    private func toggleSelectedQuote(_ quote: Quote) {
        if selectedQuote == quote {
            selectedQuote = nil
        } else {
            selectedQuote = quote
        }
    }
}

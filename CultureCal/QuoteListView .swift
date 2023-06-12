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
                    QuoteCardView(quote: quote)
                        .onTapGesture {
                            selectedQuote = quote
                        }
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            })
        }
        .sheet(item: $selectedQuote) { quote in
            QuoteDetailView(quote: quote)
        }
        
        
        
        
    }
}

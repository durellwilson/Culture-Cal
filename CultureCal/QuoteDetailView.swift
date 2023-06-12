//
//  QuoteDetailView.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

struct QuoteDetailView: View {
    let quote: Quote
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image(quote.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                
                VStack(spacing: 16) {
                    ScrollView{
                        Text(quote.additionalInfo)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    }
                    Divider()
                    
                    Text("Quote:")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    ScrollView {
                        VStack {
                            Text(quote.text)
                                .font(.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        }
                        .padding(.vertical, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                }
                .padding(.bottom, 20)
            }
            .padding(50)
            .navigationTitle(quote.author)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.blue)
            })
        }
    }
}



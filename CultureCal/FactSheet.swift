//
//  File.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/18/23.
//

import Foundation
import SwiftUI

struct FactSheet: View {
    let fact: Fact
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Text(fact.title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text(fact.content)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                withAnimation {
                    isPresented = false
                }
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
}

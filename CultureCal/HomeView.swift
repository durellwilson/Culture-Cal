//
//  SwiftUIView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/18/23.
//

import SwiftUI

struct HomeView: View {
    @State private var isCalendarViewPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Black History")
                .font(.title)
            
            Text("Learn about significant moments and achievements in black history.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                isCalendarViewPresented = true
            }) {
                Text("Start Exploring")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isCalendarViewPresented) {
                NavigationView {
                    CalendarView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: backButton)
                }
            }
        }
        .padding()
    }
    
    private var backButton: some View {
        Button(action: {
            isCalendarViewPresented = false
        }) {
            Image(systemName: "chevron.left")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

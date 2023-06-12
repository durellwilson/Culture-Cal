//
//  FactDescriptionView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/25/23.
//
import SwiftUI

struct FactDescriptionView: View {
    let fact: Fact
    let date: String
    let dateFormatter: DateFormatter
    
    @Binding var isPresented: Bool
    @Binding var isSheetPresented: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    shareFact(fact)
                }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .padding(8)
                .foregroundColor(.white)
                .background(Color("FistGreen"))
                .cornerRadius(8)
            }
            
            Text(fact.title)
                .font(.largeTitle)
                .foregroundColor(Color("FistGreen"))
            Text(fact.content)
                .font(.body)
                .foregroundColor(Color("FistGreen"))
            
            if let factDate = dateFormatter.date(from: fact.date) {
                Text(dateFormatter.string(from: factDate))
                    .font(.subheadline)
            } else {
                Text("No Date Available")
                    .font(.subheadline)
            }
        }
            
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresented = true
                    isSheetPresented = false
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
        }
        .navigationBarTitle(Text("Fact Sheet"), displayMode: .inline)
        .onDisappear {
            isSheetPresented = false
        }
    }
    
    private func shareFact(_ fact: Fact) {
        let activityItems: [Any] = [fact.title, fact.content]
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        viewController.present(activityController, animated: true, completion: nil)
    }
}

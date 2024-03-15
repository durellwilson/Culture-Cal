//
//  FactSheetView .swift
//  CultureCal
//
//  Created by Kelly Brown on 5/25/23.
//
import SwiftUI

struct FactSheet: View {
    let fact: Fact
    let dateFormatter: DateFormatter
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
           VStack(alignment: .leading, spacing: 16) {
               HStack {
                   Spacer()
                   ShareLink("", item: "\(fact.title)\n\n\(fact.content)\n\n\(formattedDateText)")
                       .font(.headline)
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
            
               Button(action: {
                   isPresented = true
                   presentationMode.wrappedValue.dismiss()
               }) {
                   Text("Close")
                       .font(.headline)
                       .foregroundColor(.white)
                       .frame(width: 70)
                       .padding()
                       .background(
                           RoundedRectangle(cornerRadius: 10)
                               .foregroundColor(Color("FistGreen"))
                       )
               }
               .padding(.horizontal,105)
           }
           .padding()
           .background(Color(.systemGray6))
           .cornerRadius(16)
           .shadow(radius: 8)
           .padding()
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button(action: {
                       isPresented = false
                       presentationMode.wrappedValue.dismiss()
                   }) {
                       Image(systemName: "xmark.circle.fill")
                           .font(.title)
                           .foregroundColor(.red)
                   }
               }
           }
           .navigationBarTitle(Text("Fact Sheet"), displayMode: .inline)
       }
       
    
    private var formattedDateText: String {
        if let factDate = dateFormatter.date(from: fact.date) {
            return dateFormatter.string(from: factDate)
        } else {
            return "No Date Available"
        }
    }
    private func shareFact(_ fact: Fact) {
        let activityItems: [Any] = [fact.title, fact.content]
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            mainWindow.rootViewController?.present(activityController, animated: true, completion: nil)
        } else if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.rootViewController?.present(activityController, animated: true, completion: nil)
        }
    }
}



//
//  Mission Statement.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import SwiftUI

let missionStatement: String = """
At CultureCal, our mission is to celebrate black achievement and illuminate history-changing events by highlighting the rich culture and contributions of black individuals. Our app offers a sleek and interactive calendar experience, combining simplicity and fun. Discover historical events, birthdays of influential black celebrities and leaders, and important cultural milestones. CultureCal is your gateway to immerse yourself in the vibrant tapestry of black history and celebrate the remarkable accomplishments that have shaped our world.
"""
struct MissionStatement: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            Image("Fist")
                .resizable()
                .frame(width: 120, height: 120)
                .padding(.top, 48)
            Text("Our Mission")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("FistGreen"))
            
            Text(missionStatement)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .padding(.horizontal)
                .foregroundColor(Color("FistGreen"))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        })
        
    }
      
    
    struct MissionStatement_Previews: PreviewProvider {
        static var previews: some View {
            MissionStatement()
        }
    }
}

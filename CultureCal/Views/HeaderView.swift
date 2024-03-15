//
//  HeaderView.swift
//  CultureCal
//
//  Created by Durell Wilson on 3/12/24.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    @State private var isFactDisplayed = false
    @State private var isFactListPresented = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(Color("Golden"))
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 35)
                        .foregroundColor(Color(.red))
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(Color("Golden"))
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 132)
                        .foregroundColor(Color(.black))
                        .overlay(
                            Text(title)
                                .font(.title)
                                .foregroundColor(Color(.white))
                                .bold()
                                .padding(.leading, 10)
                                .padding(.top, 30)
                        )
                    
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(Color("Golden"))
                    
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 35)
                        .foregroundColor(Color("FistGreen"))
                    
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(Color("Golden"))
                    
                    Spacer()
                }
                    
                VStack {
                    
                    HStack {
                        
                        NavigationLink(destination: MissionStatementView()) {
                                //image with circle barckground
                            Image("Fist")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 60, style: .continuous))
                                .overlay(RoundedRectangle(cornerRadius: 60, style: .continuous).stroke(Color("FistGreen"), lineWidth: 5))
                            
                            
                        }.padding(.leading, 10)
                        
                        
                        Spacer()
                        
                        Button(action: {
                            isFactListPresented = true
                        }) {
                            Image(systemName: "list.bullet")
                                .foregroundColor(Color("FistGreen"))
                                .padding(.bottom, 30)
                                .frame(width: 70, height: 90)
                                .imageScale(.large)
                        }
                        
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HeaderView(title: "Today In Black History")
}

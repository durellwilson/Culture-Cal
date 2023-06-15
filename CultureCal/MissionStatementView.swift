//
//  SwiftUIView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/25/23.
//
import SwiftUI

struct MissionStatementView: View {
    @State private var isCalendarViewPresented = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Image("Fist")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.top, 48)
                        .onTapGesture {
                            isCalendarViewPresented = false
                        }
                        .foregroundColor(Color("FistGreen"))
                    
                    VStack(spacing: 16) {
                        NavigationLink(destination: QuizListView()) {
                            MissionStatementButton(title: "Legacy Quiz")
                        }
                        
                        NavigationLink(destination: StemView()) {
                            MissionStatementButton(title: "Excellence in Black STEM")
                        }
                        
                        NavigationLink(destination: QuoteListView(quotes: quotes)) {
                            MissionStatementButton(title: "Motivation Zone")
                        }
                        
                        NavigationLink(destination: InkOfColorView()) {
                            MissionStatementButton(title: "Ink of Color")
                        }
                        
                        NavigationLink(destination: MissionStatement()) {
                            MissionStatementButton(title: "Our Mission")
                        }
                    }
                    .padding(.horizontal, 16)
                    .foregroundColor(Color("FistGreen"))
                    
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.white)
                        .shadow(color: Color(.systemGray4), radius: 8, x: 0, y: 2)
                )
                .padding()
                .animation(.spring())
            }
            .navigationBarBackButtonHidden(true)
            .foregroundColor(Color("FistGreen")) // Hide the back button
        }
    }
}

struct MissionStatementButton: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
    }
}


struct StemView: View {
    @State private var selectedInnovator: Innovator?
    
    let innovators: [Innovator] = [
        Innovator(name: "Mark Dean", imageName: "Mark Dean", story: "Mark Dean (1957-present): Dr. Mark Dean is a computer scientist and engineer who played a significant role in the development of the personal computer (PC). He was instrumental in the design and development of the IBM PC, and he holds three of the original nine patents for the IBM PC architecture. Dr. Dean's work has greatly influenced modern computing and is considered a key figure in the tech industry."),
        Innovator(name: "Dr. Ayanna Howard", imageName: "Dr. Ayanna Howard", story: "Dr. Ayanna Howard (1972-present): Dr. Howard is a roboticist and AI researcher who has made significant contributions to the field of robotics and human-robot interaction. Her work focuses on developing intelligent systems that can assist and empower individuals with disabilities. She has received numerous awards for her research and is a prominent figure in the field of robotics."),
        Innovator(name: "Madam C.J. Walker", imageName: "Madam C.J. Walker", story: "Madam C.J. Walker (1867-1919): While primarily known for her pioneering work in the beauty and hair care industry, Madam C.J. Walker was also an entrepreneur and philanthropist. She used her wealth to support education and donated to institutions, including the Tuskegee Institute. Her achievements as a self-made millionaire and her entrepreneurial spirit continue to inspire generations."),
        Innovator(name: "Dr. Shirley Ann Jackson", imageName: "Dr. Shirley Ann Jackson", story: "Dr. Shirley Ann Jackson (1946-present): Dr. Jackson is a theoretical physicist who became the first African-American woman to earn a Ph.D. from MIT. She conducted research at Bell Laboratories, where she made significant contributions to telecommunications theory, including the development of fiber optic cables, solar cells, and touch-tone telephones. Dr. Jackson served as the chair of the U.S. Nuclear Regulatory Commission and is currently the president of Rensselaer Polytechnic Institute."),
        Innovator(name: "Kimberly Bryant", imageName: "Kimberly Bryant", story: "Kimberly Bryant (1967-present): Kimberly Bryant is the founder of Black Girls CODE, a non-profit organization that aims to introduce young black girls to computer programming and technology. Her organization provides coding workshops and classes to empower and inspire the next generation of black innovators in tech.")
    ]
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(innovators) { innovator in
                    Button(action: {
                        toggleSelectedInnovator(innovator)
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            
                            HStack(spacing: 16) {
                                Image(innovator.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(innovator.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    if selectedInnovator != innovator {
                                        Text(innovator.story)
                                            .font(.body)
                                            .lineLimit(3)
                                    }
                                }
                            }
                            .padding(16)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if let selectedInnovator = selectedInnovator, selectedInnovator == innovator {
                        VStack {
                            Image(innovator.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                            
                            Text(innovator.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(innovator.story)
                                .font(.body)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Excellence in Black STEM")
        .foregroundColor(Color("FistGreen"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        }
                            )}
    private func toggleSelectedInnovator(_ innovator: Innovator) {
        if selectedInnovator == innovator {
            selectedInnovator = nil
        } else {
            selectedInnovator = innovator
        }
    }
}


struct Innovator: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    let story: String
}


    struct MissionStatementView_Previews: PreviewProvider {
        static var previews: some View {
            MissionStatementView()
        }
    }


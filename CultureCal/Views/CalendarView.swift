//
//  ContentView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/9/23.

import EventKit
import EventKitUI
import Social
import SwiftUI

class EventStoreManager {
    static let shared = EventStoreManager()
    internal var eventStore = EKEventStore()
    
    private init() {}
}

struct CalendarView: View {
    @State private var isFactDisplayed = false
    @State private var isFactListPresented = false
    @State private var selectedMonth = 1
    @State private var selectedDate: Date? = nil
    @State private var factOfTheDay: Fact = Fact(title: "", content: "", date: "")
    @State private var favoriteFacts: Set<Fact> = []
    @State private var selectedFact: Fact? = nil
    @State private var currentDate = Date()
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()
    
    private var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    private var dataSource: DataSource = DataSource()
    private var facts: [Fact] {
        return Array(dataSource.facts.values)
    }
    
    private var eventStore: EKEventStore {
        return EventStoreManager.shared.eventStore
    }
    
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
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity, maxHeight: 132)
                        .foregroundColor(Color(.black))
                        Text("Today In Black History")
                            .font(Font.custom("Silom", size: 30))
                            .lineSpacing(40)
                            .foregroundColor(Color(.white))
                            .multilineTextAlignment(.center)
                            .padding(.top, 50.0)

                    }
                    
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
                    
//                    ScrollView {
//                        VStack(spacing: 8) {
//                            Text("Today In Black History")
//                                .font(.headline)
//                        
//                            Text(factOfTheDay.title)
//                                .font(.headline)
//                                .foregroundColor(.red)
//                                .multilineTextAlignment(.center)
//                            
//                            Text(factOfTheDay.content)
//                                .font(.body)
//                                .foregroundColor(Color("FistGreen"))
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding(.horizontal)
//                        .padding(.leading, -5)
//                    }
                    
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(1..<13) { month in
                            Text(self.months[month - 1])
                                .tag(month)
                                .foregroundColor(Color("FistGreen"))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(.top)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 16) {
                        ForEach(getDaysOfMonth(), id: \.self) { day in
                            Button(action: {
                                withAnimation {
                                    selectedDate = day
                                    factOfTheDay = fetchFactOfTheDay(for: day)
                                    isFactDisplayed = true
                                }
                                toggleFavoriteFact(factOfTheDay)
                            }) {
                                Text(getDayNumber(from: day))
                                    .font(.headline)
                                    .frame(width: 30, height: 30)
                                    .background(
                                        Circle()
                                            .foregroundColor(getButtonColor(for: day))
                                    )
                                    .foregroundColor(Color("FistGreen"))
                                    .scaleEffect(selectedDate == day ? 1.2 : 1.0)
                                    .overlay(
                                        favoriteButtonOverlay(for: factOfTheDay)
                                            .opacity(selectedDate == day ? 1.0 : 0.0)
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.bottom, 56)
                }
                .onAppear {
                    let currentDate = Date()
                    let formattedDate = dateFormatter.string(from: currentDate)
                    factOfTheDay = dataSource.facts[formattedDate] ?? Fact(title: "Title of the Fact", content: "Content of the Fact", date: formattedDate)
                    
                    if factOfTheDay.title != "No fact available today" {
                        addOrUpdateAllDayEventToCalendar(title: factOfTheDay.title, notes: factOfTheDay.content, date: currentDate)
                    }
                }
                
                .sheet(isPresented: $isFactDisplayed) {
                    if let date = selectedDate {
                        FactSheet(fact: factOfTheDay, dateFormatter: dateFormatter, isPresented: $isFactDisplayed)
                    } else {
                        EmptyView()
                    }
                }
                .sheet(isPresented: $isFactListPresented) {
                    FactListView(facts: facts, isPresented: $isFactListPresented, selectedFact: $selectedFact)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: MissionStatementView()) {
                            Image("Fist")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 55)
                                .padding()
                        }
                    }
                            
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isFactListPresented = true
                        }) {
                            Image(systemName: "list.bullet")
                                .foregroundColor(Color("FistGreen"))
                                .padding()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func clearAndFillEventsForYear() {
        let startDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: Date()), month: 1, day: 1))!
        let endDate = calendar.date(byAdding: DateComponents(year: 1), to: startDate)!
        
        // Clear existing events for the year
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)
        
        for event in existingEvents {
            do {
                try eventStore.remove(event, span: .thisEvent)
            } catch let error as NSError {
                print("Failed to remove event with error: \(error)")
            }
        }
        
        // Add new events for each day with facts
        for dayOffset in 0..<365 { // Assuming a non-leap year
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) {
                let formattedDate = dateFormatter.string(from: date)
                if let fact = dataSource.facts[formattedDate] {
                    addOrUpdateAllDayEventToCalendar(title: fact.title, notes: fact.content, date: date)
                }
            }
        }
    }


    private func getDaysOfMonth() -> [Date] {
        let selectedComponents = DateComponents(month: selectedMonth)
        guard let selectedDate = calendar.date(from: selectedComponents),
              let range = calendar.range(of: .day, in: .month, for: selectedDate) else {
            return []
        }
        let days = range.lowerBound..<range.upperBound
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        
        return days.map { calendar.date(byAdding: .day, value: $0 - 1, to: startOfMonth)! }
    }
    
    private func fetchFactOfTheDay(for date: Date) -> Fact {
        let formattedDate = dateFormatter.string(from: date)
        if let fact = dataSource.facts[formattedDate] {
            return Fact(title: fact.title, content: fact.content, date: fact.date)
        } else {
            return Fact(title: "No Fact Available", content: "There is no historical fact available for this date.", date: "")
        }
    }
    
    private func getDayNumber(from date: Date) -> String {
        let dayNumber = calendar.component(.day, from: date)
        return "\(dayNumber)"
    }
    
    private func getButtonColor(for date: Date) -> Color {
        if calendar.isDate(date, inSameDayAs: currentDate) {
            return .red
        } else if calendar.isDate(date, inSameDayAs: selectedDate ?? Date()) {
            return .red
        } else {
            return .white
        }
    }
    
    // Function to add or update an all-day event for a given date
    private func addOrUpdateAllDayEventToCalendar(title: String, notes: String, date: Date) {
        
        let store = EventStoreManager.shared.eventStore
        
        // Check if an event already exists for this date
        if let existingEvent = eventForDate(date) {
            // Update the existing event
            existingEvent.title = title
            existingEvent.notes = notes
            do {
                try store.save(existingEvent, span: .thisEvent)
            } catch let error as NSError {
                print("Failed to update event with error: \(error)")
            }
        } else {
            // Create a new event
            switch EKEventStore.authorizationStatus(for: .event) {
            case .authorized:
                let event = EKEvent(eventStore: store)
                
                event.title = title
                event.notes = notes
                event.isAllDay = true
                event.startDate = date
                event.endDate = date
                event.calendar = store.defaultCalendarForNewEvents
                
                do {
                    try store.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("Failed to save event with error: \(error)")
                }
            case .denied:
                print("Access denied")
            case .notDetermined:
                store.requestAccess(to: .event) { granted, error in
                    if granted {
                        let event = EKEvent(eventStore: store)
                        
                        event.title = title
                        event.notes = notes
                        event.isAllDay = true
                        event.startDate = date
                        event.endDate = date
                        event.calendar = store.defaultCalendarForNewEvents
                        
                        do {
                            try store.save(event, span: .thisEvent)
                        } catch let error as NSError {
                            print("Failed to save event with error: \(error)")
                        }
                    } else {
                        print("Access denied")
                    }
                }
            default:
                print("Case Default")
            }
        }
    }
    
    // Function to iterate over all days of the year and add/update events
    private func addOrUpdateAllDayEventsForYear() {
        let currentYear = calendar.component(.year, from: Date())
        let now = Date()
        
        for day in 1...365 {
            var dateComponents = DateComponents()
            dateComponents.year = currentYear
            dateComponents.day = day
            guard let factDate = calendar.date(from: dateComponents) else {
                continue
            }
            
            // Check if the fact date is before today
            if factDate < now {
                continue
            }
            
            let fact = fetchFactOfTheDay(for: factDate)
            
            if fact.title != "No Fact Available Today" {
                addOrUpdateAllDayEventToCalendar(title: fact.title, notes: fact.content, date: factDate)
            } else {
                print("Skipping event for date: \(factDate) due to 'No Fact Available Today'")
            }
        }
    }


    private func eventForDate(_ date: Date) -> EKEvent? {
        let store = EventStoreManager.shared.eventStore
        
        let predicate = store.predicateForEvents(withStart: date, end: date, calendars: nil)
        let events = store.events(matching: predicate)
        
        return events.first
    }

    private func toggleFavoriteFact(_ fact: Fact) {
        if favoriteFacts.contains(fact) {
            favoriteFacts.remove(fact)
        } else {
            favoriteFacts.insert(fact)
        }
    }
    
    private func favoriteButtonOverlay(for fact: Fact) -> some View {
        if favoriteFacts.contains(fact) {
            return AnyView(
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(5)
                    .background(Color.white)
                    .clipShape(Circle())
            )
        }
        else {
            return AnyView(EmptyView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

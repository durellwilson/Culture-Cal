//
//  ContentView.swift
//  CultureCal
//
//  Created by Kelly Brown on 5/9/23.
import SwiftUI
import EventKit
import EventKitUI
import Social

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
    
    private var dataSource:DataSource = DataSource()
    private var facts: [Fact] {
        return Array(dataSource.facts.values)
    }
    
    private var eventStore: EKEventStore {
        return EKEventStore()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: MissionStatementView()) {
                        Image("Fist")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 75)
                            .padding()
                    }
                    
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
                
        //        if isFactDisplayed {
                    ScrollView {
                        VStack(spacing: 8) {
                            Text("Today In Black History")
                                .font(.headline)
                            
                            
                            Text(factOfTheDay.title)
                                .font(.headline)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                            
                            Text(factOfTheDay.content)
                                .font(.body)
                                .foregroundColor(Color("FistGreen"))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal)
                        .padding(.leading, -5)
                    }
             //   }
                
                // Month Picker
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1..<13) { month in
                        Text(self.months[month - 1])
                            .tag(month)
                            .foregroundColor(Color("FistGreen"))
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.top)
                
               
                
                // Calendar Days
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
                addEventToCalendar(title: factOfTheDay.title, notes: factOfTheDay.content, startDate: Date(), endDate: Date())
                
                // Get the current year
                let currentYear = calendar.component(.year, from: Date())
                
                // Iterate through each day of the year
                for day in 1...365 {
                    // Calculate the date for the current day
                    var dateComponents = DateComponents()
                    dateComponents.year = currentYear
                    dateComponents.day = day
                    guard let factDate = calendar.date(from: dateComponents) else {
                        continue
                    }
                    
                    // Check if the fact already exists in the user's calendar
                    let predicate = eventStore.predicateForEvents(withStart: factDate, end: factDate.addingTimeInterval(86400), calendars: nil)
                    let existingEvents = eventStore.events(matching: predicate)
                    
                    if existingEvents.isEmpty {
                        // Fact does not exist in the calendar, schedule it
                        let fact = fetchFactOfTheDay(for: factDate)
                        let factTitle = fact.title
                        let factContent = fact.content
                        
                        // Set the start date and end date to the same day
                        let startDate = calendar.startOfDay(for: factDate)
                        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                        
                        // Add the event to the calendar
                        addEventToCalendar(title: factTitle, notes: factContent, startDate: startDate, endDate: endDate)
                    }
                }
            }
            .onReceive(timer) { _ in
                let now = Date()
                if calendar.isDate(now, inSameDayAs: currentDate) {
                    // Check if it's 12 AM
                    let components = calendar.dateComponents([.hour, .minute], from: now)
                    if components.hour == 0 && components.minute == 0 {
                        // Update factOfTheDay
                        factOfTheDay = fetchFactOfTheDay(for: Date())
                    }
                } else {
                    currentDate = calendar.startOfDay(for: now)
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
  
        private func insertEvent(store: EKEventStore, title: String, notes: String, startDate: Date, endDate: Date) {
            let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
            let existingEvents = store.events(matching: predicate)
            
            let isEventAlreadyExists = existingEvents.contains { event in
                return event.title == title && event.startDate == startDate
            }
            
            if !isEventAlreadyExists {
                let event = EKEvent(eventStore: store)
                
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = notes
                event.calendar = store.defaultCalendarForNewEvents
                
                let alarmDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: startDate)!
                let alarm = EKAlarm(absoluteDate: alarmDate)
                event.addAlarm(alarm)
                
                do {
                    try store.save(event, span: .thisEvent)
                    // Event saved successfully
                } catch let error as NSError {
                    print("Failed to save event with error: \(error)")
                    // Handle the error appropriately
                }
            }
        }


    private func addEventToCalendar(title: String, notes: String, startDate: Date, endDate: Date) {
        let store = EventStoreManager.shared.eventStore
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            insertEvent(store: store, title: title, notes: notes, startDate: startDate, endDate: endDate)
        case .denied:
            print("Access denied")
        case .notDetermined:
            store.requestAccess(to: .event) { granted, error in
                if granted {
                    self.insertEvent(store: store, title: title, notes: notes, startDate: startDate, endDate: endDate)
                } else {
                    print("Access denied")
                }
            }
        default:
            print("Case Default")
        }
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
    
    


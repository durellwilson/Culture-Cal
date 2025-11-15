import Foundation
import EventKit
import OSLog
import SwiftUI

@MainActor
final class CalendarManager: ObservableObject {
    static let shared = CalendarManager()
    
    private let eventStore = EKEventStore()
    private let logger = Logger(subsystem: "com.culturecal.app", category: "CalendarManager")
    
    @Published private(set) var authorizationStatus: EKAuthorizationStatus = .notDetermined
    @Published private(set) var calendars: [EKCalendar] = []
    @Published private(set) var selectedCalendar: EKCalendar?
    @Published private(set) var events: [Event] = []
    @Published var error: Error?
    
    private init() {
        Task {
            await requestAccess()
        }
    }
    
    func requestAccess() async -> Bool {
        do {
            let granted = try await eventStore.requestAccess(to: .event)
            authorizationStatus = granted ? .authorized : .denied
            if granted {
                await loadCalendars()
            }
            return granted
        } catch {
            logger.error("Failed to request calendar access: \(error.localizedDescription)")
            authorizationStatus = .denied
            self.error = error
            return false
        }
    }
    
    private func loadCalendars() async {
        calendars = eventStore.calendars(for: .event)
        selectedCalendar = eventStore.defaultCalendarForNewEvents
        logger.info("Loaded \(calendars.count) calendars")
    }
    
    func createEvent(
        title: String,
        startDate: Date,
        endDate: Date,
        notes: String? = nil,
        url: URL? = nil,
        calendar: EKCalendar? = nil
    ) async throws -> EKEvent {
        guard authorizationStatus == .authorized else {
            throw CalendarError.notAuthorized
        }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.notes = notes
        event.url = url
        event.calendar = calendar ?? selectedCalendar ?? eventStore.defaultCalendarForNewEvents
        
        try eventStore.save(event, span: .thisEvent)
        logger.info("Created event: \(title)")
        
        await refreshEvents()
        return event
    }
    
    func deleteEvent(_ event: EKEvent) async throws {
        guard authorizationStatus == .authorized else {
            throw CalendarError.notAuthorized
        }
        
        try eventStore.remove(event, span: .thisEvent)
        logger.info("Deleted event: \(event.title)")
        
        await refreshEvents()
    }
    
    func fetchEvents(from startDate: Date, to endDate: Date) async throws -> [Event] {
        guard authorizationStatus == .authorized else {
            throw CalendarError.notAuthorized
        }
        
        let predicate = eventStore.predicateForEvents(
            withStart: startDate,
            end: endDate,
            calendars: [selectedCalendar].compactMap { $0 }
        )
        
        let ekEvents = eventStore.events(matching: predicate)
        return ekEvents.map(Event.init)
    }
    
    func refreshEvents() async {
        do {
            let now = Date()
            let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: 1, to: now) ?? now
            events = try await fetchEvents(from: now, to: oneMonthFromNow)
        } catch {
            logger.error("Failed to refresh events: \(error.localizedDescription)")
            self.error = error
        }
    }
    
    func selectCalendar(_ calendar: EKCalendar) {
        selectedCalendar = calendar
        Task {
            await refreshEvents()
        }
    }
}

enum CalendarError: LocalizedError {
    case notAuthorized
    case eventCreationFailed(String)
    case eventDeletionFailed(String)
    case eventFetchFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .notAuthorized:
            return "Calendar access not authorized"
        case .eventCreationFailed(let message):
            return "Failed to create event: \(message)"
        case .eventDeletionFailed(let message):
            return "Failed to delete event: \(message)"
        case .eventFetchFailed(let message):
            return "Failed to fetch events: \(message)"
        }
    }
}
import Foundation
import CoreData

@objc(CulturalEvent)
public class CulturalEvent: NSManagedObject, Identifiable {
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var details: String?
    @NSManaged public var eventDate: Date
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    @NSManaged public var isFavorite: Bool
    @NSManaged public var calendarEventId: String?
    @NSManaged public var lastSyncedAt: Date?
    @NSManaged public var category: EventCategory?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        let now = Date()
        self.id = UUID().uuidString
        self.createdAt = now
        self.updatedAt = now
        self.isFavorite = false
    }
}

extension CulturalEvent: Hashable {
    public static func == (lhs: CulturalEvent, rhs: CulturalEvent) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CulturalEvent {
    static var fetchRequest: NSFetchRequest<CulturalEvent> {
        NSFetchRequest<CulturalEvent>(entityName: "CulturalEvent")
    }
}
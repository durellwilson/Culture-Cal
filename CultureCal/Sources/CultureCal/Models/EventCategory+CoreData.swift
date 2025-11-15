import Foundation
import CoreData

@objc(EventCategory)
public class EventCategory: NSManagedObject, Identifiable {
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var color: String
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    @NSManaged public var events: Set<CulturalEvent>?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        let now = Date()
        self.id = UUID().uuidString
        self.createdAt = now
        self.updatedAt = now
    }
}

extension EventCategory: Hashable {
    public static func == (lhs: EventCategory, rhs: EventCategory) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension EventCategory {
    static var fetchRequest: NSFetchRequest<EventCategory> {
        NSFetchRequest<EventCategory>(entityName: "EventCategory")
    }
}
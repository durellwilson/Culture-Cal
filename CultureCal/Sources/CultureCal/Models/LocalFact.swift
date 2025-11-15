import CoreData

@objc(LocalFact)
public class LocalFact: NSManagedObject {
    @NSManaged public var id: Int
    @NSManaged public var dateKey: String
    @NSManaged public var title: String
    @NSManaged public var factDescription: String
    @NSManaged public var source: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
}

extension LocalFact {
    static var entityName: String { "LocalFact" }
    
    static func fetchRequest() -> NSFetchRequest<LocalFact> {
        return NSFetchRequest<LocalFact>(entityName: entityName)
    }
}

extension Fact {
    func toLocalFact(context: NSManagedObjectContext) -> LocalFact {
        let localFact = LocalFact(context: context)
        localFact.id = id ?? 0
        localFact.dateKey = dateKey
        localFact.title = title
        localFact.factDescription = description
        localFact.source = source
        localFact.imageUrl = imageUrl
        localFact.isFavorite = isFavorite
        localFact.createdAt = createdAt ?? Date()
        localFact.updatedAt = updatedAt ?? Date()
        return localFact
    }
}
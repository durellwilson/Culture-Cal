import Foundation

struct Book: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let imageName: String
    let story: String
    
    init(id: UUID = UUID(), name: String, imageName: String, story: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.story = story
    }
    
    static let preview = Book(
        name: "The Warmth of Other Suns",
        imageName: "The Warmth of Other Suns",
        story: "A powerful work about the Great Migration..."
    )
}
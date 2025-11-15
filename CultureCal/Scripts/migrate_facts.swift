import Foundation

// MARK: - Migration Configuration
struct MigrationConfig {
    static let supabaseURL = "https://ydnxrwopgkvuqvjnvwfj.supabase.co"
    static let supabaseKey = "YOUR_SERVICE_ROLE_KEY" // Use service role key for migration
    static let batchSize = 100
}

// MARK: - Models
struct LocalFact: Codable {
    let title: String
    let content: String
    let date: String
}

struct SupabaseFact: Codable {
    let id: UUID
    let title: String
    let content: String
    let date: String
    let dateKey: String
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case date
        case dateKey = "date_key"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Migration Script
@main
struct MigrationScript {
    static func main() async throws {
        print("Starting migration...")
        
        // 1. Load local facts
        guard let factsURL = Bundle.main.url(forResource: "facts", withExtension: "json") else {
            throw MigrationError.fileNotFound
        }
        
        let factsData = try Data(contentsOf: factsURL)
        let localFacts = try JSONDecoder().decode([String: LocalFact].self, from: factsData)
        
        print("Loaded \(localFacts.count) local facts")
        
        // 2. Transform facts
        let supabaseFacts = localFacts.map { (key, fact) -> SupabaseFact in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d"
            let date = dateFormatter.date(from: fact.date) ?? Date()
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "MM-dd"
            let dateKey = dateFormatter.string(from: date)
            
            return SupabaseFact(
                id: UUID(),
                title: fact.title,
                content: fact.content,
                date: dateString,
                dateKey: dateKey,
                createdAt: Date(),
                updatedAt: Date()
            )
        }
        
        print("Transformed \(supabaseFacts.count) facts")
        
        // 3. Upload to Supabase in batches
        let client = SupabaseClient(
            supabaseURL: MigrationConfig.supabaseURL,
            supabaseKey: MigrationConfig.supabaseKey
        )
        
        for batch in stride(from: 0, to: supabaseFacts.count, by: MigrationConfig.batchSize) {
            let end = min(batch + MigrationConfig.batchSize, supabaseFacts.count)
            let currentBatch = Array(supabaseFacts[batch..<end])
            
            print("Uploading batch \(batch/MigrationConfig.batchSize + 1)...")
            
            do {
                try await client.database
                    .from("facts")
                    .insert(currentBatch)
                    .execute()
                
                print("Successfully uploaded batch")
            } catch {
                print("Error uploading batch: \(error.localizedDescription)")
                throw MigrationError.uploadFailed(error)
            }
        }
        
        print("Migration completed successfully!")
    }
}

// MARK: - Errors
enum MigrationError: LocalizedError {
    case fileNotFound
    case uploadFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Local facts file not found"
        case .uploadFailed(let error):
            return "Failed to upload facts: \(error.localizedDescription)"
        }
    }
}

// MARK: - Helper Extensions
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

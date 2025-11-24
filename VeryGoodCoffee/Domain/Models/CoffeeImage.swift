import Foundation

struct CoffeeImage: Identifiable, Equatable, Codable {
    let id: UUID
    let url: URL
    let addedAt: Date
    
    init(url: URL) {
        self.id = UUID()
        self.url = url
        self.addedAt = Date()
    }
    
    // For Codable
    init(id: UUID = UUID(), url: URL, addedAt: Date = Date()) {
        self.id = id
        self.url = url
        self.addedAt = addedAt
    }
}

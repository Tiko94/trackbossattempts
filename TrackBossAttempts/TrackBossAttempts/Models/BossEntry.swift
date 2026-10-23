import SwiftUI
import SwiftData

enum BossStatus: String, Codable, CaseIterable, Identifiable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case defeated = "Defeated"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .notStarted: return .gray
        case .inProgress: return .orange
        case .defeated: return .green
        }
    }
}

@Model
final class BossEntry {
    var gameTitle: String
    var name: String
    var attempts: Int
    var statusRawValue: String
    var notes: String
    var createdAt: Date

    @Attribute(.externalStorage) var imageData: Data?

    var status: BossStatus {
        get { BossStatus(rawValue: statusRawValue) ?? .notStarted }
        set { statusRawValue = newValue.rawValue }
    }

    init(gameTitle: String, name: String,
         attempts: Int = 0,
         status: BossStatus = .notStarted,
         notes: String = "",
         imageData: Data? = nil) {
        self.gameTitle = gameTitle
        self.name = name
        self.attempts = attempts
        self.statusRawValue = status.rawValue
        self.notes = notes
        self.createdAt = Date()
        self.imageData = imageData
    }
}

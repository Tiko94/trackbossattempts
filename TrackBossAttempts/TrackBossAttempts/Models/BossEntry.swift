import SwiftUI
import SwiftData

enum BossStatus: String, Codable, CaseIterable, Identifiable, Sendable {
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
final class BossEntry: Sendable {
    var gameTitle: String = ""
    var name: String = ""
    var attempts: Int = 0
    var statusRawValue: String = BossStatus.notStarted.rawValue
    var notes: String = ""
    var createdAt: Date = Date()

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

extension BossEntry {
    var shareImage: BossShareImage {
        BossShareImage(boss: self)
    }

    var sharePreview: SharePreview<Image, Never> {
        if let imageData, let ui = UIImage(data: imageData) {
            return SharePreview(name, image: Image(uiImage: ui))
        } else {
            return SharePreview(name, image: Image(systemName: "shield.slash"))
        }
    }
}

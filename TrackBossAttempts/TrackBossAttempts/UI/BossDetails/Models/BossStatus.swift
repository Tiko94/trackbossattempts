import SwiftUI

extension BossStatus {
    var bannerFill: Color {
        switch self {
        case .notStarted: return Color.white.opacity(0.10)
        case .inProgress: return Color(red: 0.62, green: 0.38, blue: 0.13)
        case .defeated:   return Color(red: 0.55, green: 0.20, blue: 0.20)
        }
    }
}

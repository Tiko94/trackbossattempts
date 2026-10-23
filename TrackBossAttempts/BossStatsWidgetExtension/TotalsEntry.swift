import WidgetKit

struct TotalsEntry: TimelineEntry {
    let date: Date
    let totalAttempts: Int
    let totalDefeated: Int

    static let sample = TotalsEntry(date: .now, totalAttempts: 0, totalDefeated: 0)
}

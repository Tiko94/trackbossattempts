import WidgetKit
import SwiftData

struct TotalsProvider: TimelineProvider {

    func placeholder(in context: Context) -> TotalsEntry {
        .sample
    }

    func getSnapshot(in context: Context, completion: @escaping (TotalsEntry) -> Void) {
        completion(context.isPreview ? .sample : load())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TotalsEntry>) -> Void) {
        // The app calls WidgetCenter.reloadTimelines on every write, so there is
        // nothing useful to schedule ahead — .never avoids spending refresh budget.
        completion(Timeline(entries: [load()], policy: .never))
    }

    /// Reads the aggregates straight from the shared SwiftData store.
    private func load() -> TotalsEntry {
        let context = ModelContext(.shared)

        let all = (try? context.fetch(FetchDescriptor<BossEntry>())) ?? []

        return TotalsEntry(
            date: .now,
            totalAttempts: all.reduce(0) { $0 + $1.attempts },
            totalDefeated: all.filter { $0.status == .defeated }.count
        )
    }
}

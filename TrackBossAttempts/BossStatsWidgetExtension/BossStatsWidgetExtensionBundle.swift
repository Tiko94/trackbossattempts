import WidgetKit
import SwiftUI
import SwiftData

@main
struct BossStatsWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        TotalsWidget()
    }
}

extension ModelContainer {
    static let shared: ModelContainer = {
        let config = ModelConfiguration(
            groupContainer: .identifier("group.trackBossAttempts")
        )
        return try! ModelContainer(for: BossEntry.self, configurations: config)
    }()
}

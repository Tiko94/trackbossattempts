enum BossFilter {
    case all
    case defeated
    case inProgress
}

enum BossSort: String, CaseIterable, Identifiable {
    case newest = "Newest"
    case mostAttempts = "Most Attempts"
    case fewestAttempts = "Fewest Attempts"
    case oldest = "Oldest"
    case name = "Name (A–Z)"

    var id: String { rawValue }
}

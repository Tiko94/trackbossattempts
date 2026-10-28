import SwiftUI
import SwiftData
import WidgetKit

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Query(sort: \BossEntry.createdAt, order: .reverse) private var bosses: [BossEntry]

    @State private var searchText: String = ""
    @State private var showingAddSheet = false
    @State private var showStatsSheet = false

    @State private var activeFilter: BossFilter = .all
    @State private var sortOption: BossSort = .newest

    var totalAttempts: Int {
        bosses.reduce(0) { $0 + $1.attempts }
    }
    var totalDefeated: Int {
        bosses.filter { $0.status == .defeated }.count
    }

    private var columns: [GridItem] {
        let count = horizontalSizeClass == .regular ? 2 : 1
        return Array(repeating: GridItem(.flexible(), spacing: 12), count: count)
    }

    private var filtered: [BossEntry] {
        var result = bosses
        switch activeFilter {
        case .all: break
        case .defeated:   result = result.filter { $0.status == .defeated }
        case .inProgress: result = result.filter { $0.status != .defeated }
        }

        let q = searchText.trimmingCharacters(in: .whitespaces)
        if !q.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(q) ||
                $0.gameTitle.localizedCaseInsensitiveContains(q)
            }
        }

        switch sortOption {
        case .mostAttempts:   return result.sorted { $0.attempts > $1.attempts }
        case .fewestAttempts: return result.sorted { $0.attempts < $1.attempts }
        case .newest:         return result.sorted { $0.createdAt > $1.createdAt }
        case .oldest:         return result.sorted { $0.createdAt < $1.createdAt }
        case .name:           return result.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    DashboardHeader(
                        showingAddSheet: $showingAddSheet,
                        showingStats: $showStatsSheet,
                        searchText: $searchText,
                        sortOption: $sortOption,
                        showSearchBar: horizontalSizeClass == .regular,
                        bosses: bosses
                    )
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack(spacing: 16) {
                                totalAttemptsCard
                                totalDefeatedCard
                            }

                            if bosses.isEmpty {
                                ContentUnavailable(showingAddSheet: $showingAddSheet)
                                } else if filtered.isEmpty {
                                    ContentUnavailableView.search(text: searchText)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.top, 80)

                                } else {
                                    LazyVGrid(columns: columns, spacing: 12) {
                                        ForEach(filtered) { boss in
                                            NavigationLink(destination: BossDetailView(boss: boss)) {
                                                BossCardView(boss: boss)
                                            }
                                            .buttonStyle(.plain)
                                               .contextMenu {
                                                   Button("Delete", systemImage: "trash", role: .destructive) {
                                                       withAnimation(.snappy) {
                                                           modelContext.delete(boss)
                                                       }
                                                       try? modelContext.save()
                                                       WidgetCenter.shared.reloadTimelines(ofKind: "TotalsWidget")
                                                   }
                                               }
                                        }
                                    }
                                }
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .searchable(text: $searchText, prompt: "Search bosses")
        .modifier(AddBossSheetModifier(
            isPresented: $showingAddSheet,
            isFullScreen: horizontalSizeClass == .regular
        ))
    }

    private var totalAttemptsCard: some View {
        TotalAttemptsCard(title: "Total Attempts", value: "\(totalAttempts)")
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(activeFilter == .inProgress ? Color.white : .clear, lineWidth: 2)
            )
            .scaleEffect(activeFilter == .inProgress ? 1.03 : 1.0)
            .onTapGesture {
                withAnimation(.snappy) {
                    activeFilter = (activeFilter == .inProgress) ? .all : .inProgress
                }
            }
            .sensoryFeedback(.impact(weight: .medium), trigger: activeFilter)
    }

    private var totalDefeatedCard: some View {
        TotalDefeatedCard(title: "Total Defeated", value: "\(totalDefeated)")
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(activeFilter == .defeated ? Color.white : .clear, lineWidth: 2)
            )
            .scaleEffect(activeFilter == .defeated ? 1.03 : 1.0)
            .onTapGesture {
                withAnimation(.snappy) {
                    activeFilter = (activeFilter == .defeated) ? .all : .defeated
                }
            }
            .sensoryFeedback(.impact(weight: .medium), trigger: activeFilter)
    }
}

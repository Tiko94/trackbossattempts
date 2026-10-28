import SwiftUI

struct DashboardHeader: View {
    @Environment(\.horizontalSizeClass) private var sizeClass

    @Binding var showingAddSheet: Bool
    @Binding var showingStats: Bool
    @Binding var searchText: String
    @Binding var sortOption: BossSort

    var showSearchBar: Bool = false
    let bosses: [BossEntry]

    var body: some View {
        VStack {
            HStack {
                Text("Bosses").foregroundStyle(.white)
                    .font(.system(size: 40, weight: .bold))

                Spacer()

                Menu {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(BossSort.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .frame(width: 50, height: 50)
                        .background(.white.opacity(0.10), in: Circle())
                }

                Button {
                    showingStats.toggle()
                } label: {
                    Image(systemName: "chart.bar.xaxis")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .frame(width: 44, height: 44)
                        .background(.white.opacity(0.10), in: Circle())
                        .overlay(Circle().stroke(.white.opacity(0.14), lineWidth: 1))
                }
                .statsSheet(isPresented: $showingStats,
                            isFullScreen: sizeClass == .compact,
                            bosses: bosses)
                Button {
                    showingAddSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .frame(width: 44, height: 44)
                        .background(.white.opacity(0.10), in: Circle())
                        .overlay(Circle().stroke(.white.opacity(0.14), lineWidth: 1))
                }
            }
            if showSearchBar {
                SearchBarView(text: $searchText)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

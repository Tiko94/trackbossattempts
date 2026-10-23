import SwiftUI

struct DashboardHeader: View {

    @Binding var showingAddSheet: Bool
    @Binding var searchText: String
    @Binding var sortOption: BossSort

    var showSearchBar: Bool = false

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

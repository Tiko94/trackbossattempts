import SwiftUI
import SwiftData

struct StatusPicker: View {
    @Binding var status: BossStatus

    private let cardFill = Color.white.opacity(0.06)
    private let hairline = Color.white.opacity(0.09)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("STATUS")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)


            Picker("Filter", selection: $status) {
                ForEach(BossStatus.allCases) { tab in
                    Text(tab.rawValue.capitalized).tag(tab)
                }
            }
            .sensoryFeedback(.impact(weight: .medium), trigger: status)
            .pickerStyle(.segmented)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(cardFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(hairline, lineWidth: 1)
            )
        }
    }
}

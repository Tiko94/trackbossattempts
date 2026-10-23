import WidgetKit
import SwiftUI
import SwiftData

struct TotalsWidgetView: View {

    let entry: TotalsEntry

    private let green = Color(red: 0.35, green: 0.72, blue: 0.36)

    var body: some View {
        HStack(spacing: 0) {
            metric(value: entry.totalAttempts, label: "Attempts")
                .frame(maxWidth: .infinity)

            Divider()
                .overlay(Color.white.opacity(0.12))

            metric(value: entry.totalDefeated, label: "Defeated", showsDot: true)
                .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
    }

    private func metric(value: Int, label: String, showsDot: Bool = false) -> some View {
        VStack(spacing: 2) {
            HStack(spacing: 8) {
                Text("\(value)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }

            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.45))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(value) \(label)")
    }
}

struct TotalsWidget: Widget {

    let kind = "TotalsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TotalsProvider()) { entry in
            TotalsWidgetView(entry: entry)
                .containerBackground(for: .widget) {
                    LinearGradient(
                        colors: [
                            Color(red: 0.15, green: 0.26, blue: 0.42),
                            Color(red: 0.08, green: 0.14, blue: 0.24)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
        }
        .configurationDisplayName("Totals")
        .description("Your total attempts and bosses defeated.")
        .supportedFamilies([.systemMedium])
    }
}

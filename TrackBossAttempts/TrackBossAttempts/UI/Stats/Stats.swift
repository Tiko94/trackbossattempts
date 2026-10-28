import SwiftUI
import Charts

struct Stats: View {
    let bosses: [BossEntry]

    private var topFiveBosses: [BossEntry] {
        Array(bosses.sorted { $0.attempts > $1.attempts }.prefix(5))
    }

    private var maxAttempts: Int {
        topFiveBosses.map(\.attempts).max() ?? 0
    }

    private var yDomain: ClosedRange<Double> {
        0...(Double(max(maxAttempts, 1)) * 1.45)
    }

    private var yStep: Double {
        Double(max(1, Int(ceil(Double(maxAttempts) / 4.0))))
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            GradientView()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    Text("Top 5 Hardest Bosses")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)

                    chart
                    list
                }
                .padding(20)
            }
        }
    }
}

extension Stats {
    private var list: some View {
        VStack(spacing: 0) {
            ForEach(topFiveBosses) { boss in
                HStack(spacing: 14) {
                    bossIcon(boss.uiImage)

                    Text(boss.gameTitle)
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                        .lineLimit(1)

                    Spacer(minLength: 12)

                    Text(boss.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.75))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.vertical, 10)
                
                Divider()
                    .overlay(Color.white.opacity(0.12))
            }
        }
    }
}

extension Stats {
    private var chart: some View {
        Chart {
            ForEach(Array(topFiveBosses.enumerated()), id: \.element.id) { index, boss in
                bar(for: boss, at: index)
            }
        }
        .chartYScale(domain: yDomain)
        .chartYAxisLabel(position: .leading) {
            Text("Attempts")
                .foregroundStyle(.white.opacity(0.7))
                .rotationEffect(.degrees(180))
        }
        .chartYAxis { yAxisMarks }
        .chartXAxis { xAxisMarks }
        .frame(height: 360)
    }

    @ChartContentBuilder
    private func bar(for boss: BossEntry, at index: Int) -> some ChartContent {
        let label: String = "#\(index + 1)"
        let style: AnyShapeStyle = index == 0 ? AnyShapeStyle(redGradient) : AnyShapeStyle(grayGradient)

        BarMark(
            x: .value("Boss", label),
            y: .value("Attempts", boss.attempts),
            width: .ratio(0.7)
        )
        .foregroundStyle(style)
        .cornerRadius(10)
        .annotation(position: .top, spacing: 6) {
            annotationView(for: boss)
        }
    }


    @AxisContentBuilder
    private var yAxisMarks: some AxisContent {
        AxisMarks(position: .leading, values: .stride(by: yStep)) { _ in
            AxisGridLine().foregroundStyle(.white.opacity(0.15))
            AxisValueLabel().foregroundStyle(.white.opacity(0.8))
        }
    }

    @AxisContentBuilder
    private var xAxisMarks: some AxisContent {
        AxisMarks { _ in
            AxisValueLabel()
                .foregroundStyle(.white.opacity(0.9))
                .font(.system(size: 11))
        }
    }

    private func annotationView(for boss: BossEntry) -> some View {
        VStack(spacing: 4) {
            bossIcon(boss.uiImage)
            valueLabel(boss.attempts)
        }
    }

    private func valueLabel(_ value: Int) -> some View {
        Text("\(value)")
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(.white)
    }

    @ViewBuilder
    private func bossIcon(_ image: UIImage?) -> some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image(systemName: "shield.slash")
                .font(.system(size: 34, weight: .light))
                .foregroundStyle(.white.opacity(0.35))
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.07))
        }
    }
}

extension Stats {
    private var redGradient: LinearGradient {
        LinearGradient(
            colors: [Color(red: 0.85, green: 0.2, blue: 0.25),
                     Color(red: 0.6, green: 0.1, blue: 0.15)],
            startPoint: .top, endPoint: .bottom
        )
    }

    private var grayGradient: LinearGradient {
        LinearGradient(
            colors: [Color.white.opacity(0.55), Color.white.opacity(0.2)],
            startPoint: .top, endPoint: .bottom
        )
    }
}

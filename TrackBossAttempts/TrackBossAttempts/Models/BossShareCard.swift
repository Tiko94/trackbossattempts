import SwiftUI

struct BossShareCard: View {
    let boss: BossEntry

    private let gold = Color(red: 0.86, green: 0.69, blue: 0.29)
    private let goldDark = Color(red: 0.36, green: 0.25, blue: 0.06)


    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.045, blue: 0.04)

            VStack(spacing: 0) {
                banner

                VStack(alignment: .leading, spacing: 14) {
                    heroImage

                    VStack(alignment: .leading, spacing: 4) {
                        Text(boss.name)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                            .minimumScaleFactor(0.75)
                        Text("Game: \(boss.gameTitle)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.65))
                            .lineLimit(1)
                    }

                    Rectangle()
                        .fill(.white.opacity(0.12))
                        .frame(height: 1)

                    Spacer(minLength: 0)

                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("ATTEMPTS")
                                .font(.system(size: 12, weight: .semibold))
                                .tracking(1.2)
                                .foregroundStyle(.white.opacity(0.6))
                            Text("\(boss.attempts)")
                                .font(.system(size: 54, weight: .bold))
                                .foregroundStyle(.white)
                                .minimumScaleFactor(0.6)
                                .lineLimit(1)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 1) {
                            Text("Tracked via")
                                .font(.system(size: 11))
                                .foregroundStyle(.white.opacity(0.55))
                            Text("TrackBossAttempts")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(gold)
                        }
                    }
                }
                .padding(16)
            }
            .frame(width: 340, height: 500, alignment: .top)
            .background(
                LinearGradient(
                    colors: [Color(red: 0.16, green: 0.13, blue: 0.10),
                             Color(red: 0.08, green: 0.07, blue: 0.06)],
                    startPoint: .top, endPoint: .bottom)
            )
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(
                        LinearGradient(colors: [gold, gold.opacity(0.4), gold],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        lineWidth: 3)
            )
        }
        .frame(width: 360, height: 520)
        .environment(\.colorScheme, .dark)
    }

    private var banner: some View {
        HStack(spacing: 8) {
            Image(systemName: "crown.fill")
                .font(.system(size: 18, weight: .bold))
        }
        .foregroundStyle(goldDark)
        .frame(maxWidth: .infinity)
        .frame(height: 46)
        .background(
            LinearGradient(
                colors: [Color(red: 0.95, green: 0.82, blue: 0.45),
                         Color(red: 0.80, green: 0.62, blue: 0.22)],
                startPoint: .top, endPoint: .bottom)
        )
    }

    private var heroImage: some View {
        Group {
            if let imageData = boss.imageData, let ui = UIImage(data: imageData) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Color.white.opacity(0.08)
                    Image(systemName: "shield.slash")
                        .font(.system(size: 56))
                        .foregroundStyle(.white.opacity(0.4))
                }
            }
        }
        .frame(width: 308, height: 190)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(gold.opacity(0.8), lineWidth: 2)
        )
    }
}

import SwiftUI

struct BossCardView: View {
    let boss: BossEntry

    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 8) {
                if let data = boss.imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                } else {
                    Image(systemName: "shield.slash")
                        .font(.system(size: 34, weight: .light))
                        .foregroundStyle(.white.opacity(0.35))
                        .frame(width: 80, height: 80)
                        .background(Color.white.opacity(0.07))
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(boss.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    Text(boss.gameTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }

            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Spacer()
                Text("\(boss.attempts)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .fixedSize()

                Text(boss.status.rawValue)
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(boss.status.color.opacity(0.2))
                    .foregroundColor(boss.status.color)
                    .cornerRadius(6)
            }
        }
        .padding()
        .background(Color(white: 0.12))
        .cornerRadius(14)
    }
}

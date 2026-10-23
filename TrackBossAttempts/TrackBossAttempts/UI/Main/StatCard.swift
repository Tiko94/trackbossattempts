import SwiftUI

struct TotalAttemptsCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.title)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(white: 0.12))
        .cornerRadius(14)
    }
}


struct TotalDefeatedCard: View {
    let title: String
    let value: String

    let color = Color(red: 0.35, green: 0.72, blue: 0.36)

    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
            HStack(spacing: 10) {
                Circle()
                    .fill(color)
                    .frame(width: 14, height: 14)
                    .shadow(color: color.opacity(0.45), radius: 6)

                Text(value)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.16, green: 0.30, blue: 0.21),
                            Color(red: 0.10, green: 0.20, blue: 0.15)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(.white.opacity(0.09), lineWidth: 1)
                }
        }
        .cornerRadius(14)
    }
}

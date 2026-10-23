import SwiftUI

struct NotesSection: View {
    @Binding var notes: String

    private let cardFill = Color.white.opacity(0.06)
    private let hairline = Color.white.opacity(0.09)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notes")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)

            TextField("", text: $notes,
                      axis: .vertical)
                .textFieldStyle(.plain)
                .font(.system(size: 19))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .tint(Color(red: 0.35, green: 0.55, blue: 0.95))
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(cardFill)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(hairline, lineWidth: 1)
                )
                .lineLimit(3...6)
        }
    }
}


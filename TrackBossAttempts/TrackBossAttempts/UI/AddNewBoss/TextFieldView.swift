import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack(spacing: 8) {
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .font(.system(size: 19))
                .foregroundStyle(.white)
                .tint(Color(red: 0.35, green: 0.55, blue: 0.95))
                .keyboardType(keyboardType)

            if !text.isEmpty,
               keyboardType != .numberPad {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(.white.opacity(0.4))
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear text")
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(red: 0.114, green: 0.122, blue: 0.145))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.white.opacity(0.10), lineWidth: 1)
        )
    }
}

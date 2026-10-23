import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var prompt: String = "Search bosses"

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.7))

            TextField("", text: $text, prompt: Text(prompt).foregroundColor(.white.opacity(0.5)))
                .foregroundColor(.white)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

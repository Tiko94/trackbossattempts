import SwiftUI

struct ContentUnavailable: View {
    @Binding var showingAddSheet: Bool

    var body: some View {
        VStack(spacing: 24) {
            ContentUnavailableView {
                Label("No bosses yet", systemImage: "shield.slash")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
            } description: {
                Text("Track your attempts and victories. Add your first boss to get started.")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            }
            button
                .padding(.horizontal, 20)
        }
        .padding(.top, 80)
    }

    private var button: some View {
        Button(action: {
            showingAddSheet = true
        }) {
            Text("Add Boss".uppercased())
                .font(.system(size: 13, weight: .semibold))
                .tracking(0.6)
                .frame(maxWidth: .infinity)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.white)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.blue)
        )
    }
}

import SwiftUI
import SwiftData

struct AttemptsStepper: View {

    @Binding var attempts: Int

    private let minAttempts = 0

    var body: some View {
        HStack(spacing: 0) {
            stepButton(
                systemName: "minus",
                enabled: attempts > minAttempts,
                action: decrement
            )

            VStack(spacing: 0) {
                Text("\(attempts)")
                    .font(.system(size: 30,
                                  weight: .bold,
                                  design: .rounded))
                    .foregroundStyle(.white)
                    .contentTransition(.numericText(value: Double(attempts)))
                    .monospacedDigit()

                Text("Attempts")
                    .font(.system(size: 12,
                                  weight: .medium))
                    .tracking(0.4)
                    .foregroundStyle(.white.opacity(0.45))
            }
            .frame(maxWidth: .infinity)

            stepButton(
                systemName: "plus",
                enabled: true,
                action: increment
            )
        }
        .padding(8)
        .background(
            Capsule().fill(Color.white.opacity(0.10))
        )
        .overlay(
            Capsule().stroke(.white.opacity(0.14), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.35), radius: 14, y: 6)
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }

    // MARK: - Actions

    private func increment() {
        withAnimation(.snappy(duration: 0.2)) {
            attempts += 1
        }
    }

    private func decrement() {
        guard attempts > minAttempts else { return }
        withAnimation(.snappy(duration: 0.2)) {
            if attempts > 0 {
                attempts -= 1
            }
        }
    }

    private func stepButton(systemName: String,
                            enabled: Bool,
                            action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white.opacity(enabled ? 0.95 : 0.25))
                .frame(width: 56, height: 56)
                .background(
                    Circle().fill(Color.white.opacity(enabled ? 0.12 : 0.05))
                )
                .contentShape(Circle())
        }
        .buttonStyle(PressableStyle())
        .disabled(!enabled)
        .sensoryFeedback(.impact(weight: .light), trigger: attempts)
        .buttonStyle(.haptic)
    }
}

private struct PressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.90 : 1)
            .animation(.snappy(duration: 0.15), value: configuration.isPressed)
    }
}

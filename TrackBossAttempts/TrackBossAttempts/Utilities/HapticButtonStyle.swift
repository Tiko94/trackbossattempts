import SwiftUI
import UIKit

struct HapticButtonStyle: ButtonStyle {
    private let generator = UIImpactFeedbackGenerator(style: .medium)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, pressed in
                if pressed {
                    generator.impactOccurred()
                }
            }
    }
}

extension ButtonStyle where Self == HapticButtonStyle {
    static var haptic: HapticButtonStyle { HapticButtonStyle() }
}

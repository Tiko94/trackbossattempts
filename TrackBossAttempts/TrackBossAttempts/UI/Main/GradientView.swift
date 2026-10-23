import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.09, green: 0.19, blue: 0.34),
                Color(red: 0.06, green: 0.12, blue: 0.21),
                Color(red: 0.03, green: 0.06, blue: 0.12)
            ],
            startPoint: .top,
            endPoint: .bottom
        )

        RadialGradient(
            colors: [
                Color(red: 0.16, green: 0.33, blue: 0.55).opacity(0.55),
                .clear
            ],
            center: UnitPoint(x: 0.5, y: 0.05),
            startRadius: 20,
            endRadius: 420
        )
    }
}

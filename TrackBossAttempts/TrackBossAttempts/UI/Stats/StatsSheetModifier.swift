import SwiftUI

struct StatsSheetModifier: ViewModifier {
    @Binding var isPresented: Bool

    let isFullScreen: Bool
    let bosses: [BossEntry]

    func body(content: Content) -> some View {
        if isFullScreen {
            content.sheet(isPresented: $isPresented) {
                Stats(bosses: bosses)
            }
        } else {
            content.popover(isPresented: $isPresented) {
                Stats(bosses: bosses)
            }
        }
    }
}


extension View {
    func statsSheet(isPresented: Binding<Bool>,
                    isFullScreen: Bool,
                    bosses: [BossEntry]) -> some View {
        modifier(StatsSheetModifier(isPresented: isPresented,
                                    isFullScreen: isFullScreen,
                                    bosses: bosses))
    }
}

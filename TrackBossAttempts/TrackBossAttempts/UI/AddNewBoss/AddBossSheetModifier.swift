import SwiftUI

struct AddBossSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    let isFullScreen: Bool

    var bossEntity: BossEntry? = nil

    func body(content: Content) -> some View {
        if isFullScreen {
            content.fullScreenCover(isPresented: $isPresented) {
                AddNewBossView(bossEntity: bossEntity)
                    .interactiveDismissDisabled()
            }
        } else {
            content.sheet(isPresented: $isPresented) {
                AddNewBossView(bossEntity: bossEntity)
                    .interactiveDismissDisabled()
            }
        }
    }
}

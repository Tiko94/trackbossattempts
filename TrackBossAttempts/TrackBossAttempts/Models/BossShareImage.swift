import CoreTransferable
import SwiftUI
import UniformTypeIdentifiers

struct BossShareImage: Transferable {
    let boss: BossEntry

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { item in
            try await MainActor.run {
                let renderer = ImageRenderer(content: BossShareCard(boss: item.boss))
                renderer.scale = 3   // 1080 x 1620 px
                guard let data = renderer.uiImage?.pngData() else {
                    throw CocoaError(.fileWriteUnknown)
                }
                return data
            }
        }
    }
}

import SwiftUI

struct Avatar: View {

    @Binding var image: Data?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: UIImage(data: image) ?? UIImage())
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "shield.slash")
                    .font(.system(size: 34, weight: .light))
                    .foregroundStyle(.white.opacity(0.35))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.07))
            }
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(Circle().stroke(.white.opacity(0.18), lineWidth: 1))
        .shadow(color: .black.opacity(0.4), radius: 14, y: 6)
    }
}


extension BossEntry {
    var uiImage: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

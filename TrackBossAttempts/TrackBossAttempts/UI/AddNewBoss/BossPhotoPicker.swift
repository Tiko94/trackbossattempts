import SwiftUI
import PhotosUI

struct BossPhotoPicker: View {

    @Binding var imageData: Data?

    @State private var pickerItem: PhotosPickerItem?

    private let avatarSize: CGFloat = 160

    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            Text("BOSS PHOTO (Optional)")
                .font(.system(size: 13, weight: .semibold))
                .tracking(0.6)
                .foregroundStyle(.white.opacity(0.45))

            photoWell
                .frame(maxWidth: .infinity)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.173, green: 0.180, blue: 0.200))
        )
    }

    // MARK: - Photo well

    private var photoWell: some View {
        PhotosPicker(selection: $pickerItem, matching: .images) {
            ZStack(alignment: .bottomTrailing) {
                avatar
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(imageData == nil ? "Add boss photo" : "Change boss photo")
        .task(id: pickerItem) {
            guard let pickerItem else { return }
            imageData = try? await pickerItem.loadTransferable(type: Data.self)
        }
    }

    private var avatar: some View {
        Group {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } else {
                Image("boss_placeholder")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(.systemGray))
                    .offset(y: avatarSize * 0.06)
            }
        }
        .frame(width: avatarSize, height: avatarSize)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var data: Data?

    return BossPhotoPicker(imageData: $data)
        .padding()
        .background(Color(.systemBackground))
        .preferredColorScheme(.dark)
}

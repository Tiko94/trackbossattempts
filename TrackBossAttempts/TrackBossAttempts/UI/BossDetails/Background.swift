import SwiftUI

struct Background: View {

    @Binding var image: Data?
    private let pageTop    = Color(red: 0.090, green: 0.118, blue: 0.141)
    private let pageBottom = Color(red: 0.055, green: 0.070, blue: 0.094)
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [pageTop, pageBottom],
                           startPoint: .top, endPoint: .bottom)

            if let image = image {
                GeometryReader { geo in
                    Image(uiImage: UIImage(data: image) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: 260)
                        .blur(radius: 60, opaque: true)
                        .opacity(0.55)
                        .mask(
                            LinearGradient(colors: [.black, .black.opacity(0.6), .clear],
                                           startPoint: .top, endPoint: .bottom)
                        )
                }
            }
        }
        .ignoresSafeArea()
    }
}

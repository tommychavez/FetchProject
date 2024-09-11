import SwiftUI

struct AsyncImageView: View {
    let imageSize: CGFloat
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .frame(width: imageSize, height: imageSize)
        } placeholder: {
            ProgressView()
                .frame(width: imageSize, height: imageSize)
        }
    }
}

#Preview {
    AsyncImageView(imageSize: 100, imageUrl: "https://www.themealdb.com/images/media/meals/1549542877.jpg")
}

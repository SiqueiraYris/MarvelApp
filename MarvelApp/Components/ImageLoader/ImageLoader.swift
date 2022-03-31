import UIKit

final class ImageLoader: UIImageView {
    private let imageCache: ImageLoaderCacheProtocol
    private var imageURL: URL?

    init(imageCache: ImageLoaderCacheProtocol = ImageLoaderCache(urlSession: URLSession.shared,
                                                                 imageCacher: ImageCacher.shared, queue: DispatchQueue.main)) {
        self.imageCache = imageCache

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadImage(fromURL URL: URL) {
        imageURL = URL
        image = nil

        if imageCache.containsImage(from: URL) {
            image = imageCache.loadImage(from: URL)
        } else {
            imageCache.downloadImage(from: URL, completion: { [weak self] receivedImage in
                self?.image = receivedImage
            })
        }
    }
}

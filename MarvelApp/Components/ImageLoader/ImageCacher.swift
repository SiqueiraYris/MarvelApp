import UIKit

protocol ImageCacherProtocol {
    func loadImage(for key: NSString) -> UIImage?
    func cache(image: UIImage, withKey key: NSString)
}

final class ImageCacher: ImageCacherProtocol {
    private let cache = NSCache<NSString, UIImage>()
    public static let shared = ImageCacher()

    func loadImage(for key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }

    func cache(image: UIImage, withKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
}

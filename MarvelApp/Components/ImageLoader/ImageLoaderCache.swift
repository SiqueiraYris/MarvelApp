import UIKit
import NetworkKit

protocol ImageLoaderCacheProtocol {
    func containsImage(from url: URL) -> Bool
    func loadImage(from url: URL) -> UIImage?
    func downloadImage(from url: URL, completion: @escaping (_ receivedImage: UIImage?) -> Void)
}

final class ImageLoaderCache: ImageLoaderCacheProtocol {
    private let urlSession: URLSessionProtocol
    private let queue: DispatchQueueProtocol
    private let imageCacher: ImageCacherProtocol
    private var dataTask: URLSessionDataTaskProtocol?

    public init(urlSession: URLSessionProtocol,
                imageCacher: ImageCacherProtocol,
                queue: DispatchQueueProtocol) {
        self.urlSession = urlSession
        self.imageCacher = imageCacher
        self.queue = queue
    }

    public func containsImage(from url: URL) -> Bool {
        imageCacher.loadImage(for: url.absoluteString as NSString) != nil
    }

    public func loadImage(from url: URL) -> UIImage? {
        imageCacher.loadImage(for: url.absoluteString as NSString)
    }

    public func downloadImage(from url: URL, completion: @escaping (_ receivedImage: UIImage?) -> Void) {
        dataTask = urlSession.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }

            self?.queue.async {
                self?.imageCacher.cache(image: image, withKey: url.absoluteString as NSString)
                completion(image)
            }
        }
        dataTask?.resume()
    }
}

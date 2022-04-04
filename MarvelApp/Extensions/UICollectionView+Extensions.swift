import UIKit

extension UICollectionView {
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }

    func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                             for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}

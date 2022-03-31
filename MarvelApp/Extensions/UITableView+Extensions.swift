import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            register(T.self, forCellReuseIdentifier: identifier)
            return dequeueReusableCell(withIdentifier: identifier) as? T ?? T()
        }
        return cell
    }
}

import UIKit

extension UIViewController {
    func showAlert(title: String = Strings.errorTitle.text,
                   message: String?,
                   buttonTitle: String = Strings.ok.text) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showLoader() {
        let loader = LoadingViewController()
        loader.modalPresentationStyle = .overCurrentContext
        loader.modalTransitionStyle = .crossDissolve
        present(loader, animated: true, completion: nil)
    }

    func hideLoader() {
        dismiss(animated: true, completion: nil)
    }
}

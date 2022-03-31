import UIKit

final class LoadingViewController: UIViewController {
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [.flexibleLeftMargin,
                                      .flexibleRightMargin,
                                      .flexibleTopMargin,
                                      .flexibleBottomMargin]
        return indicator
    }()

    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        blurView.frame = view.bounds
        indicatorView.center = CGPoint(x: view.bounds.midX,
                                       y: view.bounds.midY)

        view.insertSubview(blurView, at: 0)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(indicatorView)
    }
}

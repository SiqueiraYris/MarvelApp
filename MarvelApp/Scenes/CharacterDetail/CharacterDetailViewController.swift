import UIKit

final class CharacterDetailViewController: UIViewController {
    private let thumbnail = UIImageView()
    private let infoContainer = UIView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let relatedComicsContainer = UIView()
    private let comicsList = UIView()

    private let viewModel: CharacterDetailViewModelProtocol

    init(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
//        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        view.backgroundColor = UIColor(red: 16/255, green: 14/255, blue: 42/255, alpha: 1)
//        view.backgroundColor = UIColor(red: 16/255, green: 14/255, blue: 42/255, alpha: 1)
//        carList.backgroundColor = UIColor(red: 16/255, green: 14/255, blue: 42/255, alpha: 1)
//        view.addSubview(carList)

        NSLayoutConstraint.activate([
//            carList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            carList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            carList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            carList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

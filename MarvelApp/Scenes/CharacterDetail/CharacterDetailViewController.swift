import UIKit

final class CharacterDetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let infoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = Colors.primaryLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let thumbnail: ImageLoader = {
        let image = ImageLoader()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Colors.neutralLight
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.neutralDark
        label.numberOfLines = 0
        return label
    }()
    private let relatedComicsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Colors.neutralLight
        label.text = Strings.relatedComicsTitle.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let relatedComicsContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = Colors.primaryLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let comicsList = ComicListView()

    private let viewModel: CharacterDetailViewModelProtocol

    init(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchComics()
    }

    private func setupViews() {
        view.backgroundColor = Colors.primaryMain
        infoContainer.backgroundColor = Colors.primaryLight

        comicsList.delegate = self

        setupData()
        setupViewHierarchy()
        setupViewConstraints()
        setupBindings()
    }

    private func setupViewHierarchy() {
        scrollView.addSubview(containerView)
        containerView.addSubview(thumbnail)
        containerView.addSubview(infoContainer)
        containerView.addSubview(relatedComicsContainer)
        infoContainer.addSubview(infoStackView)
        relatedComicsContainer.addSubview(relatedComicsLabel)
        relatedComicsContainer.addSubview(comicsList)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        view.addSubview(scrollView)
    }

    private func setupViewConstraints() {
        infoStackView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        comicsList.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            thumbnail.topAnchor.constraint(equalTo: containerView.topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            thumbnail.heightAnchor.constraint(equalToConstant: 300),

            infoContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 270),
            infoContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            infoContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            infoStackView.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 24),
            infoStackView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 24),
            infoStackView.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -24),
            infoStackView.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -24),

            relatedComicsContainer.topAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: 24),
            relatedComicsContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            relatedComicsContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            relatedComicsContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            relatedComicsLabel.topAnchor.constraint(equalTo: relatedComicsContainer.topAnchor, constant: 24),
            relatedComicsLabel.leadingAnchor.constraint(equalTo: relatedComicsContainer.leadingAnchor, constant: 24),
            relatedComicsLabel.trailingAnchor.constraint(equalTo: relatedComicsContainer.trailingAnchor, constant: -24),

            comicsList.topAnchor.constraint(equalTo: relatedComicsLabel.bottomAnchor, constant: 12),
            comicsList.leadingAnchor.constraint(equalTo: relatedComicsContainer.leadingAnchor, constant: 24),
            comicsList.trailingAnchor.constraint(equalTo: relatedComicsContainer.trailingAnchor, constant: -24),
            comicsList.heightAnchor.constraint(equalToConstant: 300),
            comicsList.bottomAnchor.constraint(equalTo: relatedComicsContainer.bottomAnchor, constant: -24),
        ])
    }

    private func setupData() {
        if let imageURL = URL(string: viewModel.getThumbnail()) {
            thumbnail.loadImage(fromURL: imageURL)
        }
        nameLabel.text = viewModel.getName()
        descriptionLabel.text = viewModel.getDescription()
        descriptionLabel.isHidden = viewModel.isDescriptionHidden()
    }

    private func setupBindings() {
        viewModel.error.bind { [weak self] message in
            self?.showAlert(message: message)
        }

        viewModel.loading.bind { [weak self] loading in
            guard let self = self else { return }

            if loading {
                self.showLoader()
            } else {
                self.comicsList.setupData(comics: self.viewModel.getComics())
                self.hideLoader()
            }
        }
    }
}

extension CharacterDetailViewController: ComicListViewDelegate {
    func validatePagination(at index: Int) {
        viewModel.validatePagination(at: index)
    }
}

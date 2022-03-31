import UIKit

final class CharacterListCell: UITableViewCell {
    private let parentView = UIView()
    private let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryLight
        view.layer.cornerRadius = 6
        return view
    }()
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let characterImage: ImageLoader = {
        let image = ImageLoader()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    private let characterName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Colors.neutralLight
        return label
    }()
    private let characterDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.neutralDark
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(from data: CharacterModel) {
        if let imageURL = URL(string: data.thumbnail) {
            characterImage.loadImage(fromURL: imageURL)
        }
        characterName.text = data.name
        characterDescription.text = data.description
        characterDescription.isHidden = data.isDescriptionHidden
    }

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        infoStackView.addArrangedSubview(characterName)
        infoStackView.addArrangedSubview(characterDescription)
        parentView.addSubview(infoContainerView)
        parentView.addSubview(characterImage)
        parentView.addSubview(infoStackView)
        addSubview(parentView)
    }

    private func setupViewConstraints() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        infoStackView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            parentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            parentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            parentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),

            infoContainerView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            infoContainerView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            infoContainerView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            infoContainerView.heightAnchor.constraint(equalToConstant: 100),

            characterImage.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 16),
            characterImage.heightAnchor.constraint(equalToConstant: 110),
            characterImage.widthAnchor.constraint(equalToConstant: 90),
            characterImage.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -12),

            infoStackView.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -12),
            infoStackView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -16)
        ])
    }
}

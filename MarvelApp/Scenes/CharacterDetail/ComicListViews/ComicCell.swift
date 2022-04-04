import UIKit

final class ComicCell: UICollectionViewCell {
    private let thumbnail: ImageLoader = {
        let image = ImageLoader()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let comicName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = Colors.neutralLight
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupData(comic: ComicModel) {
        comicName.text = comic.title
        if let imageURL = URL(string: comic.thumbnail) {
            thumbnail.loadImage(fromURL: imageURL)
        }
    }

    private func setupViewHierarchy() {
        addSubview(thumbnail)
        addSubview(comicName)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: trailingAnchor),

            comicName.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 8),
            comicName.leadingAnchor.constraint(equalTo: leadingAnchor),
            comicName.trailingAnchor.constraint(equalTo: trailingAnchor),
            comicName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

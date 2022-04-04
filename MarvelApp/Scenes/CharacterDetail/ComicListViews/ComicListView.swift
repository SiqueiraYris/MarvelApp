import UIKit

protocol ComicListViewDelegate: AnyObject {
    func validatePagination(at index: Int)
}

final class ComicListView: UIView {
    private let comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ComicCell.self)
        return collectionView
    }()

    private var comics: [ComicModel] = []
    weak var delegate: ComicListViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupData(comics: [ComicModel]) {
        self.comics = comics
        comicsCollectionView.reloadData()
    }

    private func setupViews() {
        comicsCollectionView.dataSource = self
        comicsCollectionView.delegate = self

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(comicsCollectionView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            comicsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            comicsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            comicsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            comicsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ComicListView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellForItemAt: indexPath) as ComicCell
        cell.setupData(comic: comics[indexPath.item])
        delegate?.validatePagination(at: indexPath.row)
        return cell
    }
}

extension ComicListView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 270.0
        let spacing = 64.0
        let width = (UIScreen.main.bounds.width / 2) - spacing
        return CGSize(width: width, height: height)
    }
}

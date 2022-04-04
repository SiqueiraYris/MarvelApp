import UIKit

final class CharacterListViewController: UIViewController {
    private let characterList: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.primaryMain
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel: CharacterListViewModelProtocol

    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchCharacters()
    }

    private func setupViews() {
        title = viewModel.title()
        view.backgroundColor = Colors.primaryMain

        characterList.dataSource = self
        characterList.delegate = self

        setupViewHierarchy()
        setupViewConstraints()
        setupBindings()
    }

    private func setupViewHierarchy() {
        view.addSubview(characterList)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            characterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.error.bind { [weak self] message in
            self?.showAlert(message: message)
        }

        viewModel.loading.bind { [weak self] loading in
            if loading {
                self?.showLoader()
            } else {
                self?.characterList.reloadData()
                self?.hideLoader()
            }
        }
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell() as CharacterListCell
        cell.setupData(from: viewModel.cellForRow(at: indexPath.row))
        viewModel.validatePagination(at: indexPath.row)
        return cell
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRowAt())
    }
}

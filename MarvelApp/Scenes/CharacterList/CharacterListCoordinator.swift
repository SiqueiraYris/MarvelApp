import UIKit

protocol CharacterListCoordinatorProtocol {
    func shouldShowCharacterDetails(_ character: CharacterModel)
}

final class CharacterListCoordinator: CharacterListCoordinatorProtocol {
    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() {
        let service = CharacterListService()
        let viewModel = CharacterListViewModel(service: service, coordinator: self)
        let viewController = CharacterListViewController(viewModel: viewModel)
        navigation.pushViewController(viewController, animated: true)
    }

    func shouldShowCharacterDetails(_ character: CharacterModel) {
        let carDetailsCoordinator = CharacterDetailCoordinator(navigation: navigation,
                                                               character: character)
        carDetailsCoordinator.start()
    }
}

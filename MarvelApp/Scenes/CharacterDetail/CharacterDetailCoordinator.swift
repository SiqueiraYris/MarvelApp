import UIKit

protocol CharacterDetailCoordinatorProtocol { }

final class CharacterDetailCoordinator: CharacterDetailCoordinatorProtocol {
    private let navigation: UINavigationController
    private let character: CharacterModel

    init(navigation: UINavigationController, character: CharacterModel) {
        self.navigation = navigation
        self.character = character
    }

    func start() {
        let service = CharacterDetailService()
        let viewModel = CharacterDetailViewModel(service: service,
                                                 coordinator: self,
                                                 character: character)
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        navigation.pushViewController(viewController, animated: true)
    }
}

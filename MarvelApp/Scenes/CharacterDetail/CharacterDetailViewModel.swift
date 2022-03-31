protocol CharacterDetailViewModelProtocol {
    func getName() -> String
    func getDescription() -> String?
    func getThumbnail() -> String
    func isDescriptionHidden() -> Bool
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    private let coordinator: CharacterDetailCoordinatorProtocol
    private let character: CharacterModel

    init(coordinator: CharacterDetailCoordinatorProtocol, character: CharacterModel) {
        self.coordinator = coordinator
        self.character = character
    }

    func getName() -> String {
        character.name
    }

    func getDescription() -> String? {
        character.description
    }

    func getThumbnail() -> String {
        character.thumbnail
    }

    func isDescriptionHidden() -> Bool {
        character.description.isEmpty
    }
}

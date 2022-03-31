@testable import MarvelApp

final class CharacterListCoordinatorSpy: CharacterListCoordinatorProtocol {
    var shouldShowCharacterDetailsCalled = false
    var character: CharacterModel?

    func shouldShowCharacterDetails(_ character: CharacterModel) {
        self.character = character
        shouldShowCharacterDetailsCalled = true
    }
}

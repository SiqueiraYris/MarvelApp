import XCTest
import NetworkKit
@testable import MarvelApp

final class CharacterDetailViewModelTests: XCTestCase {
    func test_getName_itShouldReturnsCorrectName() {
        let character = makeCharacterModel()
        let (sut, _) = makeSUT(character: character)

        let receivedName = sut.getName()

        XCTAssertEqual(receivedName, character.name)
    }

    func test_getThumbnail_itShouldReturnsCorrectThumbnail() {
        let character = makeCharacterModel()
        let (sut, _) = makeSUT(character: character)

        let receivedThumbnail = sut.getThumbnail()

        XCTAssertEqual(receivedThumbnail, character.thumbnail)
    }

    func test_getDescription_itShouldReturnsCorrectDescription() {
        let character = makeCharacterModel()
        let (sut, _) = makeSUT(character: character)

        let receivedDescription = sut.getDescription()

        XCTAssertEqual(receivedDescription, character.description)
    }

    func test_isDescriptionHidden_whenDescriptionIsEmpty_itShouldHidesDescription() {
        let character = makeCharacterModel(description: "")
        let (sut, _) = makeSUT(character: character)

        let isDescriptionHidden = sut.isDescriptionHidden()

        XCTAssertTrue(isDescriptionHidden)
    }

    func test_isDescriptionHidden_whenDescriptionIsNotEmpty_itShouldShowsDescription() {
        let character = makeCharacterModel(description: "any-description")
        let (sut, _) = makeSUT(character: character)

        let isDescriptionHidden = sut.isDescriptionHidden()

        XCTAssertFalse(isDescriptionHidden)
    }

    // MARK: - Helpers

    private func makeSUT(character: CharacterModel) -> (sut: CharacterDetailViewModel,
                                                        coordinator: CharacterDetailCoordinatorSpy) {
        let coordinator = CharacterDetailCoordinatorSpy()
        let sut = CharacterDetailViewModel(coordinator: coordinator,
                                           character: character)

        return (sut, coordinator)
    }

    private func makeCharacterModel(description: String = "") -> CharacterModel {
        CharacterModel(id: 1,
                       name: "any-name",
                       description: description,
                       isDescriptionHidden: description.isEmpty,
                       thumbnail: "any-thumbnail")
    }
}

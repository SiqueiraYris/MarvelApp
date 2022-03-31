import XCTest
@testable import MarvelApp

final class CharacterDetailCoordinatorTests: XCTestCase {
    func test_start_itShouldSetsViewControllerCorrectly() {
        let (sut, navigation) = makeSUT(character: makeCharacterModel())

        sut.start()

        XCTAssertTrue(navigation.viewControllers.first! is CharacterDetailViewController)
    }

    // MARK: - Helpers

    private func makeSUT(character: CharacterModel) -> (sut: CharacterDetailCoordinator,
                                                        navigation: UINavigationController) {
        let navigation = dummyNavigation()
        let sut = CharacterDetailCoordinator(navigation: navigation,
                                             character: character)

        return (sut, navigation)
    }

    private func dummyNavigation() -> UINavigationController {
        UINavigationController()
    }

    private func makeCharacterModel() -> CharacterModel {
        CharacterModel(id: 1,
                       name: "any-name",
                       description: "any-description",
                       isDescriptionHidden: Bool.random(),
                       thumbnail: "any-thumbnail")
    }
}

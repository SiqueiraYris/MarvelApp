import XCTest
@testable import MarvelApp

final class CharacterListCoordinatorTests: XCTestCase {
    func test_start_itShouldSetsViewControllerCorrectly() {
        let (sut, navigation) = makeSUT()

        sut.start()

        XCTAssertTrue(navigation.viewControllers.first! is CharacterListViewController)
    }

    func test_shouldShowCharacterDetails_itShouldSetsViewControllerCorrectly() {
        let character = makeCharacterModel()
        let (sut, navigation) = makeSUT()

        sut.shouldShowCharacterDetails(character)

        XCTAssertTrue(navigation.viewControllers.first! is CharacterDetailViewController)
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: CharacterListCoordinator,
                               navigation: UINavigationController) {
        let navigation = dummyNavigation()
        let sut = CharacterListCoordinator(navigation: navigation)

        return (sut, navigation)
    }

    private func dummyNavigation() -> UINavigationController {
        UINavigationController()
    }

    private func makeCharacterModel() -> CharacterModel {
        return CharacterModel(id: 1,
                       name: "any-name",
                       description: "any-description",
                       thumbnail: "any-thumbnail")
    }
}

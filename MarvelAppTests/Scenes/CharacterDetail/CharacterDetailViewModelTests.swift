import XCTest
import NetworkKit
@testable import MarvelApp

final class CharacterDetailViewModelTests: XCTestCase {
    func test_getName_itShouldReturnsCorrectName() {
        let character = makeCharacterModel()
        let (sut, _, _) = makeSUT(character: character)

        let receivedName = sut.getName()

        XCTAssertEqual(receivedName, character.name)
    }

    func test_getThumbnail_itShouldReturnsCorrectThumbnail() {
        let character = makeCharacterModel()
        let (sut, _, _) = makeSUT(character: character)

        let receivedThumbnail = sut.getThumbnail()

        XCTAssertEqual(receivedThumbnail, character.thumbnail)
    }

    func test_getDescription_itShouldReturnsCorrectDescription() {
        let character = makeCharacterModel()
        let (sut, _, _) = makeSUT(character: character)

        let receivedDescription = sut.getDescription()

        XCTAssertEqual(receivedDescription, character.description)
    }

    func test_isDescriptionHidden_whenDescriptionIsEmpty_itShouldHidesDescription() {
        let character = makeCharacterModel(description: "")
        let (sut, _, _) = makeSUT(character: character)

        let isDescriptionHidden = sut.isDescriptionHidden()

        XCTAssertTrue(isDescriptionHidden)
    }

    func test_isDescriptionHidden_whenDescriptionIsNotEmpty_itShouldShowsDescription() {
        let character = makeCharacterModel(description: "any-description")
        let (sut, _, _) = makeSUT(character: character)

        let isDescriptionHidden = sut.isDescriptionHidden()

        XCTAssertFalse(isDescriptionHidden)
    }

    func test_getComics_whenFetchIsNotCalled_itShouldReturnsEmptyComics() {
        let character = makeCharacterModel(description: "any-description")
        let (sut, _, _) = makeSUT(character: character)

        let comics = sut.getComics()

        XCTAssertTrue(comics.isEmpty)
    }

    func test_getComics_whenFetchIsCalled_itShouldReturnsCorrectComics() {
        let character = makeCharacterModel(description: "any-description")
        let model = makeRemoteCharacterComicsModel(comics: [makeRemoteComic()])
        let expectedModel = makeExpectedComicModel(remoteModel: makeRemoteCharacterComicsModel(comics: [makeRemoteComic()]))
        let (sut, service, _) = makeSUT(character: character)

        sut.fetchComics()
        service.completeWithSuccess(object: model)
        let receivedComicsModel = sut.getComics()

        XCTAssertEqual(receivedComicsModel, expectedModel)
    }

    func test_validatePagination_whenNumberOfComicsIsLessThanTotalAndCurrentRowIsTheLast() {
        let index = 0
        let character = makeCharacterModel()
        let model = makeRemoteCharacterComicsModel(comics: [makeRemoteComic()])

        let (sut, service, _) = makeSUT(character: character)

        sut.fetchComics()
        service.completeWithSuccess(object: model)
        sut.validatePagination(at: index)

        XCTAssertTrue(service.requestCalled)
        XCTAssertNotNil(service.routePassed)
        XCTAssertEqual(service.numberOfCalls, 2)
    }

    func test_validatePagination_whenNumberOfComicsIsLessThanTotalAndCurrentRowIsNotTheLast() {
        let index = 0
        let character = makeCharacterModel()
        let model = makeRemoteCharacterComicsModel(comics: [makeRemoteComic(),
                                                            makeRemoteComic()])
        let (sut, service, _) = makeSUT(character: character)

        sut.fetchComics()
        service.completeWithSuccess(object: model)
        sut.validatePagination(at: index)

        XCTAssertEqual(service.numberOfCalls, 1)
    }

    func test_validatePagination_whenNumberOfComicsIsGreaterThanTotalAndCurrentRowIsNotTheLast() {
        let index = 0
        let character = makeCharacterModel()
        let model = makeRemoteCharacterComicsModel(comics: [makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic(),
                                                            makeRemoteComic()])
        let (sut, service, _) = makeSUT(character: character)

        sut.fetchComics()
        service.completeWithSuccess(object: model)
        sut.validatePagination(at: index)

        XCTAssertEqual(service.numberOfCalls, 1)
    }

    func test_fetchComics_whenCompletingWithSuccess_itShouldMakesRequestCorrectly() {
        let character = makeCharacterModel()
        let comics = makeRemoteComic()
        let model = makeRemoteCharacterComicsModel(comics: [comics])
        let (sut, service, _) = makeSUT(character: character)

        sut.fetchComics()
        service.completeWithSuccess(object: model)

        XCTAssertTrue(service.requestCalled)
        XCTAssertNotNil(service.routePassed)
    }

    func test_fetchComics_whenCompletingWithError_itShouldMakesRequestCorrectly() {
        let error = ErrorHandler.fixture()
        let character = makeCharacterModel()
        let (sut, service, _) = makeSUT(character: character)

        sut.fetchComics()
        service.completeWithError(error: error)

        XCTAssertTrue(service.requestCalled)
        XCTAssertNotNil(service.routePassed)
        XCTAssertEqual(sut.error.value, error.message)
    }

    // MARK: - Helpers

    private func makeSUT(character: CharacterModel) -> (sut: CharacterDetailViewModel,
                                                        service: CharacterDetailServiceSpy,
                                                        coordinator: CharacterDetailCoordinatorSpy) {
        let service = CharacterDetailServiceSpy()
        let coordinator = CharacterDetailCoordinatorSpy()
        let sut = CharacterDetailViewModel(service: service,
                                           coordinator: coordinator,
                                           character: character)

        return (sut, service, coordinator)
    }

    private func makeCharacterModel(description: String = "") -> CharacterModel {
        CharacterModel(id: 1,
                       name: "any-name",
                       description: description,
                       isDescriptionHidden: description.isEmpty,
                       thumbnail: "any-thumbnail")
    }
}

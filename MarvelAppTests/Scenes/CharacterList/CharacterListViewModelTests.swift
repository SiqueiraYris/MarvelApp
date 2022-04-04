import XCTest
import NetworkKit
@testable import MarvelApp

final class CharacterListViewModelTests: XCTestCase {
    func test_title_itShouldReturnsCorrectTitle() {
        let (sut, _, _) = makeSUT()

        let receivedTitle = sut.title()

        XCTAssertEqual(receivedTitle, "Marvel Characters")
    }

    func test_numberOfRows_itShouldReturnsCorrectNumberOfRows() {
        let characters = makeRemoteCharacter()
        let model = makeRemoteCharacterModel(characters: [characters])
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)
        let receivedNumberOfRows = sut.numberOfRows()

        XCTAssertEqual(receivedNumberOfRows, model.data.count)
    }

    func test_cellForRow_itShouldRendersCorrectCell() {
        let index = 0
        let characters = makeRemoteCharacter()
        let model = makeRemoteCharacterModel(characters: [characters])
        let expectedModel = makeExpectedCharacterModel(remoteModel: model)[index]
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)
        let receivedCharacterModel = sut.cellForRow(at: index)

        XCTAssertEqual(receivedCharacterModel, expectedModel)
    }

    func test_heightForRowAt_itShouldReturnsCorrectHeightForRow() {
        let (sut, _, _) = makeSUT()

        let receivedHeight = sut.heightForRowAt()

        XCTAssertEqual(receivedHeight, 160)
    }

    func test_didSelectRowAt_itShouldSelectsCorrectCell() {
        let index = 0
        let characters = makeRemoteCharacter()
        let model = makeRemoteCharacterModel(characters: [characters])
        let expectedModel = makeExpectedCharacterModel(remoteModel: model)[index]
        let (sut, service, coordinator) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)
        sut.didSelectRowAt(at: index)

        XCTAssertTrue(coordinator.shouldShowCharacterDetailsCalled)
        XCTAssertEqual(coordinator.character, expectedModel)
    }

    func test_validatePagination_whenNumberOfCharactersIsLessThanTotalAndCurrentRowIsTheLast() {
        let index = 0
        let model = makeRemoteCharacterModel(characters: [makeRemoteCharacter()])
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)
        sut.validatePagination(at: index)

        XCTAssertTrue(service.requestCalled)
        XCTAssertNotNil(service.routePassed)
        XCTAssertEqual(service.numberOfCalls, 2)
    }

    func test_validatePagination_whenNumberOfCharactersIsLessThanTotalAndCurrentRowIsNotTheLast() {
        let index = 0
        let model = makeRemoteCharacterModel(characters: [makeRemoteCharacter(),
                                                          makeRemoteCharacter()])
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)
        sut.validatePagination(at: index)

        XCTAssertEqual(service.numberOfCalls, 1)
    }

    func test_validatePagination_whenNumberOfCharactersIsGreaterThanTotalAndCurrentRowIsNotTheLast() {
        let index = 0
        let model = makeRemoteCharacterModel(characters: [makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter(),
                                                          makeRemoteCharacter()])
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)
        sut.validatePagination(at: index)

        XCTAssertEqual(service.numberOfCalls, 1)
    }

    func test_fetchCharacters_whenCompletingWithSuccess_itShouldMakesRequestCorrectly() {
        let characters = makeRemoteCharacter()
        let model = makeRemoteCharacterModel(characters: [characters])
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithSuccess(object: model)

        XCTAssertTrue(service.requestCalled)
        XCTAssertNotNil(service.routePassed)
    }

    func test_fetchCharacters_whenCompletingWithError_itShouldMakesRequestCorrectly() {
        let error = ErrorHandler.fixture()
        let (sut, service, _) = makeSUT()

        sut.fetchCharacters()
        service.completeWithError(error: error)

        XCTAssertTrue(service.requestCalled)
        XCTAssertNotNil(service.routePassed)
        XCTAssertEqual(sut.error.value, error.message)
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: CharacterListViewModel,
                               service: CharacterListServiceSpy,
                               coordinator: CharacterListCoordinatorSpy) {
        let service = CharacterListServiceSpy()
        let coordinator = CharacterListCoordinatorSpy()
        let sut = CharacterListViewModel(service: service,
                                         coordinator: coordinator)

        return (sut, service, coordinator)
    }
}

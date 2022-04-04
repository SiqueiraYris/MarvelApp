import XCTest
@testable import MarvelApp

final class CharacterDetailMapperTests: XCTestCase {
    func test_map_whenHasDescription_itShouldReturnsCorrectModel() {
        let description = "any-description"
        let remoteModel = makeRemoteCharacterComicsModel(comics: [makeRemoteComic(description: description)])
        let receivedModel = CharacterDetailMapper.map(from: remoteModel)
        let expectedModel = makeExpectedComicModel(remoteModel: remoteModel)

        XCTAssertEqual(receivedModel, expectedModel)
    }

    func test_map_whenDescriptionIsEmpty_itShouldReturnsCorrectModel() {
        let description = "any-description"
        let remoteModel = makeRemoteCharacterComicsModel(comics: [makeRemoteComic(description: description)])
        let receivedModel = CharacterDetailMapper.map(from: remoteModel)
        let expectedModel = makeExpectedComicModel(remoteModel: remoteModel)

        XCTAssertEqual(receivedModel, expectedModel)
    }
}

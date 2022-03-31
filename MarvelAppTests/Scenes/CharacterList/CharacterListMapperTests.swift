import XCTest
@testable import MarvelApp

final class CharacterListMapperTests: XCTestCase {
    func test_map_whenHasDescription_itShouldReturnsCorrectModel() {
        let description = "any-description"
        let remoteModel = makeRemoteCharacterModel(characters: [makeRemoteCharacter(description: description)])
        let receivedModel = CharacterListMapper.map(from: remoteModel)
        let expectedModel = makeExpectedCharacterModel(remoteModel: remoteModel)

        XCTAssertEqual(receivedModel, expectedModel)
    }

    func test_map_whenDescriptionIsEmpty_itShouldReturnsCorrectModel() {
        let description = ""
        let remoteModel = makeRemoteCharacterModel(characters: [makeRemoteCharacter(description: description)])
        let receivedModel = CharacterListMapper.map(from: remoteModel)
        let expectedModel = makeExpectedCharacterModel(remoteModel: remoteModel)

        XCTAssertEqual(receivedModel, expectedModel)
    }
}

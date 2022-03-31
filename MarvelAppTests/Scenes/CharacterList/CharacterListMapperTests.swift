import XCTest
@testable import MarvelApp

final class CharacterListMapperTests: XCTestCase {
    func test_map_itShouldReturnsCorrectModel() {
        let expectedModel = makeExpectedCharacterModel()
        let receivedModel = CharacterListMapper.map(from: makeRemoteCharacterModel())

        XCTAssertEqual(receivedModel, expectedModel)
    }

    // MARK: - Helpers

    private func makeRemoteCharacterModel() -> RemoteCharacterModel {
        RemoteCharacterModel(data: makeRemoteCharacterModelData())
    }

    private func makeRemoteCharacterModelData() -> RemoteCharacterModelData {
        RemoteCharacterModelData(offset: 0,
                                 limit: 1,
                                 total: 1,
                                 count: 1,
                                 characters: [makeRemoteCharacter()])
    }

    private func makeRemoteCharacter() -> RemoteCharacter {
        RemoteCharacter(id: 1,
                        name: "any-name",
                        description: "any-description",
                        thumbnail: makeRemoteThumbnail())
    }

    private func makeRemoteThumbnail() -> RemoteThumbnail {
        RemoteThumbnail(path: "any-path",
                        type: "any-type")
    }

    private func makeExpectedCharacterModel() -> [CharacterModel] {
        [CharacterModel(id: 1,
                        name: "any-name",
                        description: "any-description",
                        thumbnail: "any-path.any-type")]
    }
}

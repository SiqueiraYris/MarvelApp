@testable import MarvelApp

func makeRemoteCharacterModel(characters: [RemoteCharacter]) -> RemoteCharacterModel {
    RemoteCharacterModel(data: makeRemoteCharacterModelData(characters: characters))
}

func makeRemoteCharacterModelData(characters: [RemoteCharacter]) -> RemoteCharacterModelData {
    RemoteCharacterModelData(offset: 0,
                             limit: 1,
                             total: 10,
                             count: 1,
                             characters: characters)
}

func makeRemoteCharacter(description: String = "any-description") -> RemoteCharacter {
    RemoteCharacter(id: 1,
                    name: "any-name",
                    description: description,
                    thumbnail: makeRemoteThumbnail())
}

func makeRemoteThumbnail() -> RemoteThumbnail {
    RemoteThumbnail(path: "any-path",
                    type: "any-type")
}

func makeExpectedCharacterModel(remoteModel: RemoteCharacterModel) -> [CharacterModel] {
    return remoteModel.data.characters.map {
        CharacterModel(id: $0.id,
                       name: $0.name,
                       description: $0.description,
                       isDescriptionHidden: $0.description.isEmpty,
                       thumbnail: $0.thumbnail.path + "." + $0.thumbnail.type)
    }
}

func makeRemoteCharacterComicsModel(comics: [RemoteComic]) -> RemoteCharacterComicsModel {
    RemoteCharacterComicsModel(data: makeRemoteCharacterComicsDataModel(comics: comics))
}

func makeRemoteCharacterComicsDataModel(comics: [RemoteComic]) -> RemoteCharacterComicsDataModel {
    RemoteCharacterComicsDataModel(offset: 0,
                                   limit: 1,
                                   total: 10,
                                   count: 1,
                                   comics: comics)
}

func makeRemoteComic(description: String = "any-description") -> RemoteComic {
    RemoteComic(id: 1,
                title: "any-title",
                resultDescription: description,
                thumbnail: makeRemoteThumbnail())
}

func makeRemoteThumbnail() -> RemoteComicThumbnail {
    RemoteComicThumbnail(path: "any-path",
                         type: "any-type")
}

func makeExpectedComicModel(remoteModel: RemoteCharacterComicsModel) -> [ComicModel] {
    return remoteModel.data.comics.map {
        ComicModel(title: $0.title,
                   thumbnail: $0.thumbnail.path + "." + $0.thumbnail.type)
    }
}

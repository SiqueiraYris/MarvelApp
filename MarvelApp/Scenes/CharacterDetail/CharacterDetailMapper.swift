final class CharacterDetailMapper {
    static func map(from model: RemoteCharacterComicsModel) -> [ComicModel] {
        model.data.comics.map {
            ComicModel(title: $0.title,
                       thumbnail: $0.thumbnail.path + Strings.thumbnailSeparator.text + $0.thumbnail.type)
        }
    }
}

final class CharacterListMapper {
    static func map(from model: RemoteCharacterModel) -> [CharacterModel] {
        model.data.characters.map {
            CharacterModel(id: $0.id,
                           name: $0.name,
                           description: $0.description,
                           isDescriptionHidden: $0.description.isEmpty,
                           thumbnail: $0.thumbnail.path + Strings.thumbnailSeparator.text + $0.thumbnail.type)
        }
    }
}

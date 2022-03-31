struct RemoteCharacterModelData: Decodable {
    let offset, limit, total, count: Int
    let characters: [RemoteCharacter]

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case characters = "results"
    }
}

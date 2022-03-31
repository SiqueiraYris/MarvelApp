struct RemoteCharacter: Decodable {
    let id: Int
    let name, description: String
    let thumbnail: RemoteThumbnail

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case thumbnail
    }
}

struct RemoteComic: Decodable {
    let id: Int
    let title: String
    let resultDescription: String?
    let thumbnail: RemoteComicThumbnail

    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail
        case resultDescription = "description"
    }
}

struct RemoteCharacterComicsDataModel: Decodable {
    let offset, limit, total, count: Int
    let comics: [RemoteComic]

    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case comics = "results"
    }
}

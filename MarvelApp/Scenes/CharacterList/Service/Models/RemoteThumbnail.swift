struct RemoteThumbnail: Codable {
    let path: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case path
        case type = "extension"
    }
}

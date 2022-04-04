import NetworkKit

enum CharacterDetailServiceRoute: NetworkRouteProtocol {
    case prepare(characterId: Int, parameters: CharacterDetailParameters)

    var config: RequestConfigProtocol {
        switch self {
        case .prepare(let characterId, let parameters):
            return configureRequest(characterId: characterId, parameters: parameters)
        }
    }

    private func configureRequest(characterId: Int, parameters: CharacterDetailParameters) -> RequestConfigProtocol {
        let config = RequestConfig(host: "gateway.marvel.com",
                                   path: "/v1/public/characters/\(characterId)/comics",
                                   method: .get,
                                   parameters: parameters.toAnyDictionary())

        return ParametersDecorator(config).config
    }
}

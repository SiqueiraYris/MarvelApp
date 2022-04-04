import NetworkKit

enum CharacterDetailServiceRoute: NetworkRouteProtocol {
    case prepare(parameters: CharacterDetailParameters)

    var config: RequestConfigProtocol {
        switch self {
        case .prepare(let parameters):
            return configureRequest(parameters: parameters)
        }
    }

    private func configureRequest(parameters: CharacterDetailParameters) -> RequestConfigProtocol {
        let config = RequestConfig(host: "gateway.marvel.com",
                                   path: "/v1/public/characters/1011334/comics",
                                   method: .get,
                                   parameters: parameters.toAnyDictionary(),
                                   debugMode: true)

        return ParametersDecorator(config).config
    }
}

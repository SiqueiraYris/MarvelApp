import NetworkKit

enum CharacterListServiceRoute: NetworkRouteProtocol {
    case prepare(parameters: CharacterListParameters)

    var config: RequestConfigProtocol {
        switch self {
        case .prepare(let parameters):
            return configureRequest(parameters: parameters)
        }
    }

    private func configureRequest(parameters: CharacterListParameters) -> RequestConfigProtocol {
        let config = RequestConfig(host: "gateway.marvel.com",
                                   path: "/v1/public/characters",
                                   method: .get,
                                   parameters: parameters.toAnyDictionary())

        return ParametersDecorator(config).config
    }
}

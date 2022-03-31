import NetworkKit

typealias CharacterListResult = (Result<(RemoteCharacterModel), ErrorHandler>)

protocol CharacterListServiceProtocol: AnyObject {
    func request(_ route: CharacterListServiceRoute, completion: @escaping(CharacterListResult) -> Void)
}

final class CharacterListService {
    private let networkManager: NetworkManagerProtocol

    public init(networking: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networking
    }
}

extension CharacterListService: CharacterListServiceProtocol {
    func request(_ route: CharacterListServiceRoute, completion: @escaping(CharacterListResult) -> Void) {
        networkManager.request(with: route.config, completion: completion)
    }
}

import NetworkKit

typealias CharacterDetailResult = (Result<(RemoteCharacterComicsModel), ErrorHandler>)

protocol CharacterDetailServiceProtocol: AnyObject {
    func request(_ route: CharacterDetailServiceRoute, completion: @escaping(CharacterDetailResult) -> Void)
}

final class CharacterDetailService {
    private let networkManager: NetworkManagerProtocol

    public init(networking: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networking
    }
}

extension CharacterDetailService: CharacterDetailServiceProtocol {
    func request(_ route: CharacterDetailServiceRoute, completion: @escaping(CharacterDetailResult) -> Void) {
        networkManager.request(with: route.config, completion: completion)
    }
}

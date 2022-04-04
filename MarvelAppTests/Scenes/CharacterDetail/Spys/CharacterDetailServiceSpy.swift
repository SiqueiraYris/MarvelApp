import NetworkKit
@testable import MarvelApp

final class CharacterDetailServiceSpy: CharacterDetailServiceProtocol {
    private var completionPassed: ((CharacterDetailResult) -> Void)?
    private(set) var routePassed: CharacterDetailServiceRoute?
    private(set) var requestCalled = false
    private(set) var numberOfCalls = 0

    func request(_ route: CharacterDetailServiceRoute, completion: @escaping(CharacterDetailResult) -> Void) {
        routePassed = route
        completionPassed = completion

        requestCalled = true
        numberOfCalls+=1
    }

    func completeWithSuccess(object: RemoteCharacterComicsModel) {
        completionPassed?(.success((object)))
    }

    func completeWithError(error: ErrorHandler) {
        completionPassed?(.failure(error))
    }
}

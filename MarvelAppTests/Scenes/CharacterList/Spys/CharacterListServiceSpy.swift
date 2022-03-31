import NetworkKit
@testable import MarvelApp

final class CharacterListServiceSpy: CharacterListServiceProtocol {
    private var completionPassed: ((CharacterListResult) -> Void)?
    private(set) var routePassed: CharacterListServiceRoute?
    private(set) var requestCalled = false
    private(set) var numberOfCalls = 0

    func request(_ route: CharacterListServiceRoute, completion: @escaping(CharacterListResult) -> Void) {
        routePassed = route
        completionPassed = completion

        requestCalled = true
        numberOfCalls+=1
    }

    func completeWithSuccess(object: RemoteCharacterModel) {
        completionPassed?(.success((object)))
    }

    func completeWithError(error: ErrorHandler) {
        completionPassed?(.failure(error))
    }
}

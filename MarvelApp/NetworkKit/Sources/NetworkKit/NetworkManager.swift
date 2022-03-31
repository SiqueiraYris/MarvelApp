import Foundation

public final class NetworkManager {
    private let session: URLSessionProtocol
    private let queue: DispatchQueueProtocol
    private let decoder: JSONDecoderProtocol

    public init(queue: DispatchQueueProtocol = DispatchQueue.main,
                session: URLSessionProtocol = URLSession(configuration: .default),
                decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.session = session
        self.queue = queue
        self.decoder = decoder
    }

    private func validateStatusCode(with code: Int) throws {
        switch code {
        case 200...299:
            break

        case 400:
            throw NetworkErrors.HTTPErrors.badRequest

        case 401:
            throw NetworkErrors.HTTPErrors.unauthorized

        case 403:
            throw NetworkErrors.HTTPErrors.forbidden

        case 404:
            throw NetworkErrors.HTTPErrors.notFound

        case 408:
            throw NetworkErrors.HTTPErrors.timeOut

        case 500:
            throw NetworkErrors.HTTPErrors.internalServerError

        default:
            throw NetworkErrors.decoderFailure
        }
    }
}

extension NetworkManager: NetworkManagerProtocol {
    public func request<T: Decodable>(with config: RequestConfigProtocol,
                                      completion: @escaping (Result<(T), ErrorHandler>) -> Void) {
        makeRequest(with: config, completion: completion)
    }

    private func makeRequest<T: Decodable>(with config: RequestConfigProtocol,
                                           completion: @escaping (Result<(T), ErrorHandler>) -> Void) {
        guard let urlRequest = config.createUrlRequest() else {
            completion(.failure(ErrorHandler(decoder: decoder, defaultError: NetworkErrors.malformedUrl)))
            return
        }

        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.queue.async {
                do {
                    if let response = response as? HTTPURLResponse {
                        try self?.validateStatusCode(with: response.statusCode)

                        try self?.handleSuccess(urlRequest: urlRequest,
                                                data: data,
                                                isDebugMode: config.debugMode,
                                                completion: completion)
                    } else {
                        try self?.validateErrorCode(with: error)
                    }
                } catch let error {
                    self?.handleError(urlRequest: urlRequest,
                                      data: data,
                                      error: error,
                                      isDebugMode: config.debugMode,
                                      completion: completion)
                }
            }
        }

        task.resume()
    }

    private func decodeHeaderWith<H: Decodable>(object: H.Type, data: [AnyHashable: Any]) throws -> H? {
        return try? decoder.decode(H.self, from: JSONSerialization.data(withJSONObject: data))
    }

    private func handleSuccess<T: Decodable>(urlRequest: URLRequest,
                                             data: Data?,
                                             isDebugMode: Bool,
                                             completion: @escaping (Result<T, ErrorHandler>) -> Void) throws {
        printDebugData(isDebugMode: isDebugMode,
                       title: "Decoding",
                       url: urlRequest.url?.absoluteString,
                       data: data,
                       curl: urlRequest.curlString)

        guard let data = data else {
            throw NetworkErrors.noData
        }

        let object = try decoder.decode(T.self, from: data.value)
        completion(.success(object))
    }

    private func handleError<T>(urlRequest: URLRequest,
                                data: Data?,
                                error: Error,
                                isDebugMode: Bool,
                                completion: @escaping (Result<T, ErrorHandler>) -> Void) {
        printDebugData(isDebugMode: isDebugMode,
                       title: String(describing: error),
                       url: urlRequest.url?.absoluteString,
                       data: data,
                       curl: urlRequest.curlString)

        let networkError = createNetworkError(error)

        completion(.failure(ErrorHandler(decoder: decoder,
                                         statusCode: networkError.code,
                                         data: data,
                                         defaultError: networkError)))
    }

    private func createNetworkError(_ error: Error) -> NetworkErrorsProtocol {
        if error is DecodingError {
            return NetworkErrors.decoderFailure
        }

        if let error = error as? NetworkErrors {
            return error
        }

        if let error = error as? NetworkErrors.HTTPErrors {
            return error
        }

        return NetworkErrors.unknownFailure
    }

    private func validateErrorCode(with error: Error?) throws {
        guard let error = error else {
            throw NetworkErrors.unknownFailure
        }

        switch error._code {
        case NetworkErrors.connectionLost.code:
            throw NetworkErrors.connectionLost

        case NetworkErrors.notConnected.code:
            throw NetworkErrors.notConnected

        default:
            throw NetworkErrors.requestFailure
        }
    }

}

extension NetworkManager {
    func printDebugData(isDebugMode: Bool, title: String, url: String?, data: Data?, curl: String?) {
        if isDebugMode {
            print("---------------------------------------------------------------")
            print("🔬 - DEBUG MODE ON FOR: \(title) - 🔬")
            print("📡 URL: \(url ?? "No URL passed")")
            print(data?.toString() ?? "No Data passed")
            print(curl ?? "No curl command passed")
            print("---------------------------------------------------------------")
        }
    }
}

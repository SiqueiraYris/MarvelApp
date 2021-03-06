import Foundation

public extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}

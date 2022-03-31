import Foundation

extension Data {
    public func toDictionary<T>() -> [String: T] {
        let text = String(data: self, encoding: .utf8) ?? ""

        if let data = text.data(using: .utf8) {
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: T] else {
                    return [:]
                }
                return dict

            } catch {
                return [:]
            }
        }
        return [:]
    }
}

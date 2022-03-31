import Foundation

extension Encodable {
    public func toAnyDictionary() -> [String: Any] {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return [:]
        }

        return jsonData.toDictionary()
    }

    public func toStringDictionary() -> [String: String] {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return [:]
        }

        return jsonData.toDictionary()
    }
}

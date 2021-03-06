public struct RequestConfig: RequestConfigProtocol {
    public var host: String
    public var path: String
    public var method: HTTPMethod
    public var parameters: [String: Any]
    public var headers: [String: String]
    public var parametersEncoding: ParameterEncoding
    public var debugMode: Bool

    public init(host: String,
                path: String,
                method: HTTPMethod = .get,
                encoding: ParameterEncoding = .url,
                parameters: [String: Any] = [:],
                headers: [String: String] = [:],
                debugMode: Bool = false) {
        self.host = host
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.parametersEncoding = encoding
        self.debugMode = debugMode
    }
}

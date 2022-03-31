public final class ParametersDecorator {
    private var configuration: RequestConfig

    public init(_ configuration: RequestConfig) {
        self.configuration = configuration
    }
}

extension ParametersDecorator: NetworkRouteProtocol {
    public var config: RequestConfigProtocol {
        configuration.parameters["ts"] = "1231231231"
        configuration.parameters["apikey"] = "aeef33699d22d8a0eb5cfcbed435fee6"
        configuration.parameters["hash"] = "e89c27f67e116eff7ca9d7da72447bc4" 

        return configuration
    }
}

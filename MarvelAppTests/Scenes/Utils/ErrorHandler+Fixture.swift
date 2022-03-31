import NetworkKit

extension ErrorHandler {
    public static func fixture(statusCode: Int? = 500,
                               errorCode: String = "any-error-code",
                               errorMessage: String = "any-error-message") -> ErrorHandler {
        var errorHandler = ErrorHandler(statusCode: statusCode,
                                        message: errorMessage)
        errorHandler.errorCode = errorCode

        return errorHandler
    }
}

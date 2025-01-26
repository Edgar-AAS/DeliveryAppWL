enum LoginError: Error {
    case invalidCredentials
    case noConnectivity
    case unexpected
    
    var message: String {
        switch self {
        case .invalidCredentials:
            return Strings.LoginAccount.Failure.invalidCredentials
        case .noConnectivity:
            return Strings.NetworkError.noConnectivity
        case .unexpected:
            return Strings.NetworkError.unexpected
        }
    }
}

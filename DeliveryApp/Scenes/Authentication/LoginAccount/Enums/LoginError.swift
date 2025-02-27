enum LoginError: Error {
    case invalidCredentials
    case noConnectivity
    case unexpected
    
    var customMessage: String {
        switch self {
        case .invalidCredentials:
            return "Email e/ou senha inválidos."
        case .noConnectivity:
            return "Você está offline. Por favor, verifique sua conexão de internet."
        case .unexpected:
            return "Ocorreu um erro inesperado. Tente novamente."
        }
    }
}

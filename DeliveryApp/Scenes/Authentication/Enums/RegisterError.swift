import Foundation

enum RegisterError: Error {
    case emailInUse
    case noConnectivity
    case unexpected
    
    var customMessage: String {
        switch self {
        case .emailInUse:
            return "Este Email já esta cadastrado a uma conta."
        case .noConnectivity:
            return "Você está offline. Por favor, verifique sua conexão de internet."
        case .unexpected:
            return "Ocorreu um erro inesperado, tente novamente em instantes."
        }
    }
}

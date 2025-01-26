import Foundation


struct Strings {
    struct RegistrationAccount {
        struct Success {
            static let title = "Sua conta foi criada!"
            static let description = "Agora você pode entrar em sua conta com email e senha cadastradas."
            static let verifyAccountTitle = "Verificar conta"
        }
        
        struct Failure {
            static let unexpectedError = "Não foi possível criar a conta, tente novamente em instantes."
            static let validationFailureTitle = "Falha na validação"
            static let unsignedTerms = "Para criar sua conta, confirme que você leu e concorda com os Termos de Serviço."
            static let emailInUse = "Este Email já esta cadastrado a uma conta"
        }
    }
    
    struct CreateAccount {
        struct Failure {
            static let emailInUse = "Este Email já esta cadastrado a uma conta."
        }
    }
    
    struct LoginAccount {
        struct Failure {
            static let invalidCredentials = "Email e/ou senha inválidos."
        }
    }
        
    struct NetworkError {
        static let noConnectivity = "Você está offline. Por favor, verifique sua conexão de internet."
        static let serverError = "O servidor está temporariamente indisponível. Tente novamente mais tarde."
        static let timeout = "A conexão está demorando muito. Por favor, tente novamente."
        static let unexpected = "Ocorreu um erro inesperado. Tente novamente."
        static let errorTitle = "Error"
    }
}

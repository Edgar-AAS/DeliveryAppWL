import Foundation


struct Strings {
    static let error = "Erro"
    
    struct RegistrationAccount {
        struct Failure {
            static let validationFailureTitle = "Falha na validação"
            static let unsignedTerms = "Para criar sua conta, confirme que você leu e concorda com os Termos de Serviço."
            static let emailInUse = "Este Email já esta cadastrado a uma conta"
        }
    }
    
    struct RegisterSucceedScreen {
        static let titleLabel = "Sua conta foi criada!"
        static let descriptionLabel = "Agora você pode entrar em sua conta com email e senha cadastradas."
        static let buttonTitle = "Verificar conta"
    }
    
    struct Keychain {
        struct Keys {
            static let accessToken = "accessToken"
        }
    }
}

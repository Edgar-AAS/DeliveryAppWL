import Foundation


struct Strings {
    struct FieldValidationMessages {
        static let emailEmpty = "O campo E-mail é obrigatório"
        static let emailInvalid = "O campo E-mail está inválido"
        static let usernameEmpty = "O campo Nome é obrigatório"
        static let phoneEmpty = "O campo Telefone é obrigatório"
        static let phoneInvalid = "O campo Telefone é inválido"
        static let passwordEmpty = "O campo Senha é obrigatório"
        static let confirmPasswordEmpty = "O campo Confirmação de senha é obrigatório"
        static let passwordsDoNotMatch = "Os campos de senha devem coincidir"
    }
    
    struct AlertViewMessages {
        static let errorTitle = "Erro"
        static let errorMessage = "Algo inesperado aconteceu, tente novamente em instantes."
        static let validationFailureTitle = "Falha na validação"
        static let validationFailureDescription = "Para criar sua conta, confirme que você leu e concorda com os Termos de Serviço."
    }

    struct RegistrationSuccess {
        static let title = "Sua conta foi Criada!"
        static let description = "Agora você pode entrar em sua conta com email e senha cadastradas."
        static let buttonTitle = "Verificar conta"
    }
}

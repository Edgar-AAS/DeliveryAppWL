import Foundation
@testable import DeliveryApp

func makeLoginCredential(email: String = "any_email@gmail.com",
                             password: String = "any_Password") -> LoginCredential {
    return LoginCredential(email: email, password: password)
}

func makeRegisterUserRequest(email: String = "valid_email@gmail.com",
                             username: String = "Any_Name",
                             password: String = "Any_Password",
                             confirmPassword: String = "Any_Password") -> RegisterUserRequest {
    
    return RegisterUserRequest(email: email, username: username, password: password, confirmPassword: confirmPassword)
}

func makeRegistrationSuccessModel() -> RegisterSucceedModel {
    return RegisterSucceedModel(
        image: "Illustration-Success",
        title: "Sua conta foi criada com sucesso!",
        description: "Agora você pode entrar em sua conta com email e senha cadastradas.",
        buttonTitle: "Verify Account"
    )
}

func makeUrl() -> URL {
    return URL(string: "htttp://someurl.com")!
}

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Edgar\"}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

import Foundation
@testable import DeliveryApp

func makeLoginCredential(email: String = "any_email@gmail.com",
                             password: String = "any_Password") -> AuthResquest {
    return AuthResquest(email: email, password: password)
}

func makeRegisterUserRequest(email: String = "valid_email@gmail.com",
                             username: String = "any_Name",
                             password: String = "any_Password",
                             confirmPassword: String = "any_Password") -> RegisterUserRequest {
    
    return RegisterUserRequest(
        email: email,
        username: username,
        password: password,
        confirmPassword: confirmPassword
    )
}

func makeAccountModel() -> CreateAccountModel {
    return CreateAccountModel(
            name: "SomeName",
            email: "someEmail@gmail.com",
            password: "someValidPasword"
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

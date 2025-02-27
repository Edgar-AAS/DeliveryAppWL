import Foundation
@testable import DeliveryApp

func makeLoginCredential(email: String = "any_email@gmail.com",
                             password: String = "any_Password") -> AuthRequest {
    return AuthRequest(email: email, password: password)
}

func makeRegisterUserRequest(email: String = "valid_email@gmail.com",
                             username: String = "any_Name",
                             password: String = "any_Password",
                             confirmPassword: String = "any_Password") -> RegisterAccountModel {
    
    return RegisterAccountModel(
        email: email,
        username: username,
        password: password,
        confirmPassword: confirmPassword
    )
}

func makeLoginAccountResponse() -> Data? {
    let jsonData = """
    {
        "accessToken": "exemploDeToken123",
        "userId": 10
    }
    """.data(using: .utf8)
    return jsonData
}

func makeAccountModel() -> RegisterAccountRequest {
    return RegisterAccountRequest(
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

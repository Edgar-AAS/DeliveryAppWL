import Foundation

protocol CreateAccountUseCase {
    func create(with request: CreateAccountModel, completion: @escaping (Result<CreateAccountStatusResponse, HttpError>) -> Void)
}

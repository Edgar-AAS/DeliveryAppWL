import Foundation

protocol CreateAccountUseCase {
    func create(with request: CreateAccountModel, completion: @escaping (Result<CreateAccountResponse, HttpError>) -> Void)
}

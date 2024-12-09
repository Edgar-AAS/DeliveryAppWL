import Foundation

protocol CreateAccountUseCase {
    var registerAccountResource: ((CreateAccountModel) -> ResourceModel)? { get set }
    func create(with request: CreateAccountModel, completion: @escaping (Result<Void, RegisterError>) -> Void)
}

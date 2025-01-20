import Foundation

final class FetchProfileData: FetchProfileDataUseCase {
    private let httpResource: ResourceModel
    private let httpClient: HTTPClientProtocol
    private let logger: LoggerProtocol?
    
    init(httpClient: HTTPClientProtocol, httpResource: ResourceModel, logger: LoggerProtocol? = nil) {
        self.httpClient = httpClient
        self.httpResource = httpResource
        self.logger = logger
    }
    
    func fetch(onComplete: @escaping (Result<ProfileDataRequest, FetchProfileDataError>) -> Void) {
        httpClient.load(httpResource) { [weak self] result in
            switch result {
            case .success(let data):
                if let profileResponse: ProfileDataRequest  = data?.toModel() {
                    onComplete(.success(profileResponse))
                } else {
                    self?.logger?.log("Erro ao decodificar o JSON")
                }
            case .failure(let httpError):
                switch httpError {
                case .badRequest:
                    self?.logger?.log("O corpo da requisição é inválido")
                case .unauthorized:
                    self?.logger?.log("O usuário não esta autorizado para receber os dados de perfil")
                case .notFound:
                    self?.logger?.log("Não existe usuário para o ID informado")
                default:
                    self?.logger?.log("Erro do servidor")
                }
            }
        }
    }
}


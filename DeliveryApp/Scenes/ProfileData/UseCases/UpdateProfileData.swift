import Foundation

final class UpdateProfileData: UpdateProfileDataUseCase {
    var httpResource: ((UpdateProfileDataRequest) -> ResourceModel)?
    
    private let httpClient: HTTPClientProtocol
    private let logger: LoggerProtocol?
   
   init(httpClient: HTTPClientProtocol, logger: LoggerProtocol? = nil) {
       self.httpClient = httpClient
       self.logger = logger
   }
    
    
    func update(with request: UpdateProfileDataRequest, onComplete: @escaping (Result<Void, UpdateProfileDataError>) -> Void) {
        guard let httpResourceModel = httpResource?(request) else {
            onComplete(.failure(.unexpectedError))
            return
        }
        
        httpClient.load(httpResourceModel) { [weak self] result in
            switch result {
            case .success(_):
                onComplete(.success(()))
            case .failure(let httpError):
                switch httpError {
                    case .badRequest:
                        self?.logger?.log("O corpo da requisição é inválido")
                    case .unauthorized:
                        self?.logger?.log("O usuário não esta autorizado para editar os detalhes do perfil")
                    case .notFound:
                        self?.logger?.log("Não existe usuário para o ID informado")
                default:
                    self?.logger?.log("Erro do servidor")
                }
                onComplete(.failure(.unexpectedError))
            }
        }
    }
}

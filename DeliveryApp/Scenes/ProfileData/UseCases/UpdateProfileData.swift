import Foundation

final class UpdateProfileData: UpdateProfileDataUseCase {
    var httpResource: ((UpdateProfileDataRequest) -> ResourceModel)?
    
    private let httpClient: HTTPClientProtocol
   
   init(httpClient: HTTPClientProtocol) {
       self.httpClient = httpClient
   }
    
    
    func update(with request: UpdateProfileDataRequest, onComplete: @escaping (Result<Void, UpdateProfileDataError>) -> Void) {
        guard let httpResourceModel = httpResource?(request) else {
            onComplete(.failure(.unexpectedError))
            return
        }
        
        httpClient.load(httpResourceModel) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(_):
                onComplete(.success(()))
            case .failure(let httpError):
                switch httpError {
                    case .badRequest:
                        print("O corpo da requisição é inválido")
                    case .unauthorized:
                    print("O usuário não esta autorizado para editar os detalhes do perfil")
                    case .notFound:
                    print("Não existe usuário para o ID informado")
                default:
                    print("Erro do servidor")
                }
                onComplete(.failure(.unexpectedError))
            }
        }
    }
}

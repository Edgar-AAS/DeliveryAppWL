import Foundation

final class FetchProfileData: FetchProfileDataUseCase {
    private let httpResource: ResourceModel
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol, httpResource: ResourceModel) {
        self.httpClient = httpClient
        self.httpResource = httpResource
    }
    
    func fetch(onComplete: @escaping (Result<ProfileDataRequest, FetchProfileDataError>) -> Void) {
        httpClient.load(httpResource) { [weak self] result in
            guard self != nil else {
                return
            }
            
            switch result {
            case .success(let data):
                if let profileResponse: ProfileDataRequest  = data?.toModel() {
                    onComplete(.success(profileResponse))
                } else {
                    print("Erro ao decodificar o JSON")
                }
            case .failure(let httpError):
                switch httpError {
                case .badRequest:
                    print("O corpo da requisição é inválido")
                case .unauthorized:
                    print("O usuário não esta autorizado para receber os dados de perfil")
                case .notFound:
                    print("Não existe usuário para o ID informado")
                default:
                    print("Erro do servidor")
                }
            }
        }
    }
}


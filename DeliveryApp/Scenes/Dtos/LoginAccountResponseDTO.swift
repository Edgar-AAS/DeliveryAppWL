import Foundation

struct LoginAccountResponseDTO: Model {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}

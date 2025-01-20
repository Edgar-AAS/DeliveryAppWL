import Foundation

struct AuthResponse: Model {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}

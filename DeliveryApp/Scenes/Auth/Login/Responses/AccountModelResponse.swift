import Foundation

struct AccountModelResponse: Model  {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}

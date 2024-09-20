import Foundation

struct AccountModel: Model  {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}

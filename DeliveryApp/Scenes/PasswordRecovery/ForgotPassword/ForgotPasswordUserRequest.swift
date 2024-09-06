import Foundation

struct ForgotPasswordUserRequest {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}

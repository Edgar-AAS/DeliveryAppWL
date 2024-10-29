import Foundation

struct RegisterUserRequest: Model {
    let email: String
    let username: String
    let password: String
    let confirmPassword: String
    
    init(email: String,
         username: String,
         password: String,
         confirmPassword: String) {
        
        self.email = email
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

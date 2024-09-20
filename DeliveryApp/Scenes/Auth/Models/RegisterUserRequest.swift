import Foundation

struct RegisterUserRequest: Model {
    let email: String
    let username: String
    let phone: String
    let password: String
    let confirmPassword: String
    
    init(email: String,
         username: String,
         phone: String,
         password: String,
         confirmPassword: String) {
        
        self.email = email
        self.username = username
        self.phone = phone
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

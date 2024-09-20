import Foundation

struct UserPostModel: Model {
    let name: String
    let email: String
    let phone: String
    let password: String
    
    init(name: String, email: String, phone: String, password: String) {
        self.name = name
        self.email = email
        self.phone = phone
        self.password = password
    }
}

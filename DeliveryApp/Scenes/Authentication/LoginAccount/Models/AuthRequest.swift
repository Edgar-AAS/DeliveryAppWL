import Foundation

struct AuthRequest: Serializable {
    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

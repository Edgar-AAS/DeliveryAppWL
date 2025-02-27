import Foundation

struct UserProfileRequest: Serializable {
    let name: String
    let email: String
    let phone: String?
    var gender: String?
    let dateOfBirth: String?
}

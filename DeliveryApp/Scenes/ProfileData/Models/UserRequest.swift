struct UserRequest: Model {
    let name: String
    let email: String
    let imageBase64: String?
    let phone: String?
    var gender: String?
    let dateOfBirth: String?
}

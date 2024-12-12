struct UpdateProfileRequestDTO: Model {
    let name: String
    let email: String
    let imageBase64: String?
    let gender: String?
    let phone: String?
    let dateOfBirth: String?
}

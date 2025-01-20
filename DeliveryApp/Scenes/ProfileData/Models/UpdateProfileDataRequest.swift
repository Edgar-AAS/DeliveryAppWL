struct UpdateProfileDataRequest: Model {
    let name: String
    let email: String
    let imageBase64: String?
    let phone: String?
    let dateOfBirth: String?
}

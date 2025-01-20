struct ProfileDataRequest: Model {
    let id: Int
    let name: String
    let email: String
    let imageBase64: String?
    let phone: String?
    let gender: String?
    let dateOfBirth: String?
}

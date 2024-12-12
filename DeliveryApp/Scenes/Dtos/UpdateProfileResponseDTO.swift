struct UpdateProfileResponseDTO: Model {
    let name: String
    let email: String
    let imageBase64: String?
    let phone: String?
    let gender: String?
    let dateOfBirth: String?
    let createAt: String
    let updateAt: String
}

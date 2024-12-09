import Foundation

struct User: Equatable {
    var id: String?
    var avatarUrl: String?
    let name: String
    let email: String
    let dateOfBirth: String
    let phone: String
    var adresses: [Adress]?
}

struct Adress: Equatable {
    var street: String
    var number: String
    var complement: String?
    var city: String
    var state: String
    var cep: String
    
    init(street: String,
         number: String,
         complement: String,
         city: String,
         state: String,
         cep: String)
    {
        self.street = street
        self.number = number
        self.complement = complement
        self.city = city
        self.state = state
        self.cep = cep
    }
}

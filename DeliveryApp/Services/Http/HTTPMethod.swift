import Foundation

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put (Data?)
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .put:
            return "PUT"
        }
    }
}

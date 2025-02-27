import Foundation

enum RequestError: Error {
    case noConnectivity
    case forbidden
    case badRequest
    case serverError
    case unknown
    case unauthorized
    case notFound
    case invalidResponse
    case conflict
}



import Foundation

enum HttpError: Error {
    case noConnectivity
    case forbidden
    case badRequest
    case serverError
    case noContent
    case timeout
    case unknown
    case unauthorized
    case notFound
}

import Foundation

enum HttpError: Error {
    case noConnectivity
    case forbidden
    case badRequest
    case serverError
    case timeout
    case unknown
    case unauthorized
    case notFound
    case invalidResponse
    case decodingFailed
}

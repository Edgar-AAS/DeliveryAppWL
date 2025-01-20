import Foundation

enum RegisterError: Error {
    case emailInUse
    case noConnectivity
    case unexpected
}

import Foundation

protocol LoggerProtocol {
    func log(_ message: String)
}

struct ConsoleLogger: LoggerProtocol {
    func log(_ message: String) {
        print("[LOG] \(Date()): \(message)")
    }
}

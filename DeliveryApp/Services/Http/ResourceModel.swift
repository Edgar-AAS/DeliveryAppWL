import Foundation

struct Resource {
    let url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
}

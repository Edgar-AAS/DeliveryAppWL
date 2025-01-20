import Foundation

struct ResourceModel {
    let url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
}

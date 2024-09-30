import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        guard let data = try? JSONDecoder().decode(T.self, from: self) else {
            return nil
        }
        return data
    }
}

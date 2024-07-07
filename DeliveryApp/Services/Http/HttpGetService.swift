import Foundation


enum HttpError: Error {
    case noConnectivity
    case forbidden
    case badRequest
    case serverError
    case noContent
}

protocol HtttpGetClientProtocol {
    func get(with url: URL, completion: @escaping ((Result<Data?, HttpError>) -> Void))
}

class HttpGetService: HtttpGetClientProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get(with url: URL, completion: @escaping ((Result<Data?, HttpError>) -> Void)) {
        urlSession.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = (response as? HTTPURLResponse) else { return
                    completion(.failure(.noConnectivity))
                }
                
                if let data = data {
                    switch response.statusCode {
                    case 204:
                        completion(.failure(.noContent))
                    case 200...299:
                        completion(.success(data))
                    case 403:
                        completion(.failure(.forbidden))
                    case 400...499:
                        completion(.failure(.badRequest))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.noConnectivity))
                    }
                }
            } else {
                completion(.failure(.noConnectivity))
            }
        }.resume()
    }
}


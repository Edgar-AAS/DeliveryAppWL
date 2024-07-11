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
            if let error = error as NSError? {
                switch error.code {
                case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                    completion(.failure(.noConnectivity))
                case NSURLErrorTimedOut:
                    completion(.failure(.timeout))
                default:
                    completion(.failure(.unknown))
                }
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }

            switch response.statusCode {
            case 200...299:
                completion(.success(data))
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 403:
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            case 500...599:
                completion(.failure(.serverError))
            default:
                completion(.failure(.unknown))
            }
        }.resume()
    }
}


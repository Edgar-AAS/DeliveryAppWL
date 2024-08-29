import Foundation


protocol HTTPClientProtocol {
    func load<T: Codable>(_ resource: Resource<T>, completion: @escaping ((Result<Data?, HttpError>) -> Void))
}

class HTTPClient: HTTPClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func load<T: Codable>(_ resource: Resource<T>, completion: @escaping ((Result<Data?, HttpError>) -> Void)) {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                
                guard let url = components?.url else {
                    completion(.failure(.badRequest))
                    return
                }
                request.url = url
            case .post(let data), .put(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .delete:
                request.httpMethod = resource.method.name
        }
        
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        session.dataTask(with: request) { data, response, error in
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
                completion(.failure(.invalidResponse))
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

//
//  LocalData.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 24/04/24.
//

import Foundation

class LocalData: HttpGet {
    private let resource: String
    
    init(resource: String) {
        self.resource = resource
    }
    
    func get(with url: URL, completion: @escaping ((Result<Data?, HttpError>) -> Void)) {
        if let url = Bundle.main.url(forResource: resource, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                print("error \(error)")
            }
        }
    }
}
    

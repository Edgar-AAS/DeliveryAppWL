//
//  Model.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

protocol Model: Codable, Equatable {}

extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func toJson() -> [String: Any]? {
        guard let data = self.toData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
